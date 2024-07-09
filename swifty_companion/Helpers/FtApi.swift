//
//  FtApi.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import Foundation

class FtApiClient {
    static let shared = FtApiClient()
    private var _onLogout: () -> Void = {}
    
    enum ApiError: Error {
        case getToken
        case noCode
        case invalidToken
        case invalidUrl
        case requestFailed
        case invalidResponse
        case invalidState
        case notFound
        case tooManyRequests
        case unhandledError(any Error)
    }
    
    private struct OAuthConfig {
        static var consumerKey: String {
            return ConfigHelper.shared.getFromConfig(key: ConfigHelper.Keys.API_KEY)
        }
        
        static var consumerSecret: String {
            return ConfigHelper.shared.getFromConfig(key: ConfigHelper.Keys.API_SECRET)
        }
        
        static let apiPrefix = "https://api.intra.42.fr"
        static let authorizeUrl = "\(apiPrefix)/oauth/authorize"
        static let accessTokenUrl = "\(apiPrefix)/oauth/token"
        static let callbackUrl = "swiftyCompanion://callback"
    }
    
    init() {}
    
    func authorizeUrl() throws -> URL? {
        let state = try KeychainHelper.shared.generate(key: "oauth_state", length: 64)
        print("generated state:", state)
        
        var urlBuilder = URLComponents(string: OAuthConfig.authorizeUrl)
        let parameters = [
            "client_id": OAuthConfig.consumerKey,
            "redirect_uri": OAuthConfig.callbackUrl,
            "scope": "public",
            "state": state,
            "response_type": "code"
        ]
        
        urlBuilder?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlBuilder?.url
    }
    
    func onLogout(_ f: @escaping () -> Void) {
        self._onLogout = f
    }
    
    func logout() throws {
        try KeychainHelper.shared.delete(key: "authorization_code")
        try KeychainHelper.shared.delete(key: "oauth_state")
        try KeychainHelper.shared.delete(key: "access_token")
        self._onLogout()
    }
    
    func getToken() throws -> Token {
        let tokenString = try KeychainHelper.shared.load(key: "access_token")

        // TODO
        //  - refresh if expired
        guard !tokenString.isEmpty,
            let tokenData = tokenString.data(using: .utf8),
            let token = try? JSONDecoder().decode(Token.self, from: tokenData)
        else {
            throw ApiError.invalidToken
        }
        
        guard token.expiresAt >= Date() else {
            // refresh token
            return token
        }
        
        return token
    }
    
    func isAuthenticated() -> Bool {
        return (try? getToken()) != nil
    }
    
    private func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
      }

    func handleCallback(url: URL) throws {
        let urlString = url.absoluteString
        guard let urlState = getQueryStringParameter(url: urlString, param: "state") else {
            throw ApiError.invalidResponse
        }
        print("urlState", urlState)
    
        let state = try KeychainHelper.shared.load(key: "oauth_state")
        print("state", state)
        
        guard urlState == state else {
            throw ApiError.invalidState
        }
        
        guard let authorizationCode = getQueryStringParameter(url: urlString, param: "code")
        else {
            throw ApiError.invalidResponse
        }
        
        try KeychainHelper.shared.save(key: "authorization_code", data: authorizationCode, override: true)
    }
    
    func makeRequest(url: URL, method: String, body: Data?, completion: @escaping (Result<Data, ApiError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
        let token = try? getToken()
        if token != nil {
            request.setValue("Bearer \(token!.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                    (200...399).contains(httpResponse.statusCode)
            else {
                print(httpResponse.statusCode)
                switch httpResponse.statusCode {
                case 404:
                    completion(.failure(.notFound))
                case 401:
                    self._onLogout()
                    completion(.failure(.invalidToken))
                case 429:
                    completion(.failure(.tooManyRequests))
                default:
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func fetchAccessToken(completion: @escaping (Result<Token, ApiError>) -> Void) {
        // TODO Add refresh token query
        guard let url = URL(string: OAuthConfig.accessTokenUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        guard let authorizationCode = try? KeychainHelper.shared.load(key: "authorization_code") else {
            completion(.failure(.noCode))
            return
        }
        
        let bodyParameters = [
            "grant_type": "authorization_code",
            "client_id": OAuthConfig.consumerKey,
            "client_secret": OAuthConfig.consumerSecret,
            "code": authorizationCode,
            "redirect_uri": OAuthConfig.callbackUrl
        ]
        
        let bodyString = bodyParameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        let bodyData = bodyString.data(using: .utf8)
        
        makeRequest(url: url, method: "POST", body: bodyData) { result in
            switch result {
            case .success(let data):
                do {
                    let tokenResponse = try JSONDecoder().decode(Token.self, from: data)
                    let jsonToken = String(data: try JSONEncoder().encode(tokenResponse), encoding: .utf8)!
                    try KeychainHelper.shared.save(key: "access_token", data: jsonToken, override: true)
                    completion(.success(tokenResponse))
                } catch (let error) {
                    completion(.failure(.unhandledError(error)))
                    return
                }
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func fetchUser(_ login: String, completion: @escaping (Result<User, ApiError>) -> Void) {
        let path = login == "me" ? "/me" : "/users/\(login)"
        
        guard let url = URL(string: "\(OAuthConfig.apiPrefix)/v2\(path)") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        makeRequest(url: url, method: "GET", body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch (let error) {
                    completion(.failure(.unhandledError(error)))
                    return
                }
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
