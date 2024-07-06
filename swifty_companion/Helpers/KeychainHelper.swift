//
//  KeychainHelper.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import Foundation
import Security
import SwiftUI

class KeychainHelper {
    static let shared = KeychainHelper()
    
    enum KeychainError: Error {
        case unhandledError(OSStatus, context: String?)
        case noData
        case unexpectedValue
        case duplicateItem
    }
    
    private init() {}
    
    func generate(key: String, length: Int = 32) throws -> String {
        var data = Data(count: length)
        let result = data.withUnsafeMutableBytes { mutableBytes in
            SecRandomCopyBytes(kSecRandomDefault, length, mutableBytes)
        }
        
        guard result == errSecSuccess else { throw KeychainError.unhandledError(result, context: "generate/generate")}
        let value = data.base64EncodedString()
        try self.save(key: key, data: value, override: true)
        return value
    }
    
    func save(key: String, data: String, override: Bool = false) throws {
        guard let encodedData = data.data(using: .utf8) else { throw KeychainError.unexpectedValue }
        print("saving data: \n\tkey: \(key)\n\tdata: \(data)")
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: ConfigHelper.bundleIdentifier + "." + key,
            kSecValueData as String: encodedData
          ]
        
        if override {
            let status = SecItemDelete(query as CFDictionary)
            guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status, context: "save/delete") }
        }
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status, context: "save/add") }
    }
    
    func load(key: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: ConfigHelper.bundleIdentifier + "." + key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        print("fetching data: \n\tkey: \(key)")
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noData }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status, context: "load/copyMatching") }
        
        guard let data = item as? Data,
              let value = String(data: data, encoding: .utf8)
        else {
            throw KeychainError.unexpectedValue
        }
        
        return value
    }
    
    func delete(key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: ConfigHelper.bundleIdentifier + "." + key,
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status, context: "delete/delete") }
    }
}
