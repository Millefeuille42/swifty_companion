//
//  Token.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String?
    let expiresAt: Date
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.tokenType = try container.decode(String.self, forKey: .tokenType)
        self.expiresIn = try container.decode(Int.self, forKey: .expiresIn)
        self.refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)

        if let expiresAtString = try container.decodeIfPresent(String.self, forKey: .expiresAt) {
            let formatter = ISO8601DateFormatter()
            if let expiresAtDate = formatter.date(from: expiresAtString) {
                print("reading Date")
                self.expiresAt = expiresAtDate
            } else {
                print("Could not decode date")
                throw DecodingError.dataCorruptedError(forKey: .expiresAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
        } else {
            print("creating Date")
            self.expiresAt = Date().addingTimeInterval(TimeInterval(expiresIn))
        }
    }
    
    // Encoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(tokenType, forKey: .tokenType)
        try container.encode(expiresIn, forKey: .expiresIn)
        try container.encodeIfPresent(refreshToken, forKey: .refreshToken)

        let formatter = ISO8601DateFormatter()
        let expiresAtString = formatter.string(from: expiresAt)
        try container.encode(expiresAtString, forKey: .expiresAt)
    }
}
