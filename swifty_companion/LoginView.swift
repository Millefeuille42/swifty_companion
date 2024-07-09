//
//  LoginView.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.errorMessage != nil {
            Text(viewModel.errorMessage ?? "Error")
                .foregroundColor(.red)
        } else if viewModel.isAuthenticated {
            MainView(onLogout: viewModel.handleLogout)
        } else {
            NavigationView {
                NavigationLink(
                    destination: WebView(url: viewModel.authorizationUrl, onCustomLink: viewModel.handleCallback),
                    label: {
                        Text("Login with OAuth")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
            }
        }
    }
}

extension LoginView {
    @Observable
    class ViewModel {
        var isAuthenticated: Bool = false
        var authorizationUrl: URL?
        var errorMessage: String?
        
        init() {
            initSelf()
        }
        
        private func initSelf() {
            FtApiClient.shared.onLogout {
                // TODO display alert
                self.handleLogout()
            }
            self.isAuthenticated = FtApiClient.shared.isAuthenticated()
            if (self.isAuthenticated) { return }
                
            do {
                self.authorizationUrl = try FtApiClient.shared.authorizeUrl()
            } catch KeychainHelper.KeychainError.unhandledError(let status, let context) {
                self.errorMessage = "Failed to interact with keychain storage: \(status) (\(context ?? "no context"))"
            } catch (let error) {
                self.errorMessage = "Failed to generate authorization URL: \(error)"
            }
        }
        
        func handleLogout() {
            try? FtApiClient.shared.logout()
            initSelf()
        }
        
        func handleCallback(url: URL) {
            do {
                try FtApiClient.shared.handleCallback(url: url)
                fetchAccessToken()
            } catch (let error) {
                self.errorMessage = "Failed to handle callback: \(error)"
            }
        }
        
        private func fetchAccessToken() {
            FtApiClient.shared.fetchAccessToken() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.isAuthenticated = true
                    case .failure(let error):
                        self.errorMessage = "Failed to fetch access token: \(error)"
                    }
                }
            }
        }
    }
}


#Preview {
    LoginView()
}
