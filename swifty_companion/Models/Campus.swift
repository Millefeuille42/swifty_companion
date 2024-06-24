//
//  Campus.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import Foundation

// MARK: - Campus
struct Campus: Codable {
    let id: Int
    let name, timeZone: String
    let language: Language
    let usersCount, vogsphereID: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case timeZone = "time_zone"
        case language
        case usersCount = "users_count"
        case vogsphereID = "vogsphere_id"
    }
}

// MARK: - Language
struct Language: Codable {
    let id: Int
    let name, identifier, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, identifier
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - CampusUser
struct CampusUser: Codable {
    let id, userID, campusID: Int
    let isPrimary: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case campusID = "campus_id"
        case isPrimary = "is_primary"
    }
}

// MARK: - ExpertisesUser
struct ExpertisesUser: Codable {
    let id, expertiseID: Int
    let interested: Bool
    let value: Int
    let contactMe: Bool
    let createdAt: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case expertiseID = "expertise_id"
        case interested, value
        case contactMe = "contact_me"
        case createdAt = "created_at"
        case userID = "user_id"
    }
}


// MARK: - LanguagesUser
struct LanguagesUser: Codable {
    let id, languageID, userID, position: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case languageID = "language_id"
        case userID = "user_id"
        case position
        case createdAt = "created_at"
    }
}
