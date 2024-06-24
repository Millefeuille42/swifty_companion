//
//  Cursus.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import Foundation

// MARK: - CursusUser
struct CursusUser: Codable, Identifiable {
    let id: Int
    let grade: String?
    let level: Float?
    let skills: [Skill]
    let cursusID: Int
    let hasCoalition: Bool
    let user: UserDigest
    let cursus: CursusDigest

    enum CodingKeys: String, CodingKey {
        case id, grade, level
        case skills
        case cursusID = "cursus_id"
        case hasCoalition = "has_coalition"
        case user, cursus
    }
}

// MARK: - CursusDigest
struct CursusDigest: Codable {
    let id: Int
    let name: String
    let slug: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}

// MARK: - UserDigest
struct UserDigest: Codable {
    let id: Int
    let login: String
    let url: String
}

// MARK: - Skill
struct Skill: Codable, Identifiable {
    let id: Int
    let name: String
    let level: Float

    enum CodingKeys: String, CodingKey {
        case id, name, level
    }
}
