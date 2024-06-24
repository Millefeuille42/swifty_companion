//
//  Project.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import Foundation

// MARK: - ProjectUser
struct ProjectUser: Codable, Identifiable {
    let id: Int
    let finalMark: Int?
    let status: String
    let validated: Bool?
    let project: ProjectDigest
    let cursusIds: [Int]
    let marked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case finalMark = "final_mark"
        case status
        case validated = "validated?"
        case project
        case cursusIds = "cursus_ids"
        case marked
    }
}

// MARK: - ProjectDigest
struct ProjectDigest: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}
