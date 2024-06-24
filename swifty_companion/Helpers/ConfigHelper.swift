//
//  ConfigHelper.swift
//  swify_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import Foundation

class ConfigHelper {
    static let shared = ConfigHelper()
    
    private init() {}
    
    enum Keys {
        static let API_KEY = "APP_CONSUMER_KEY"
        static let API_SECRET = "APP_CONSUMER_SECRET"
    }
    
    static let bundleIdentifier: String = {
        guard let id = Bundle.main.bundleIdentifier else {
            print("Bundle identifier not found")
            return ""
        }
        return id
    }()
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    func getFromConfig<T>(key: String) -> T {
        guard let val = ConfigHelper.infoDictionary[key] as? T else {
            fatalError(key + " not found")
        }
        return val
    }
}
