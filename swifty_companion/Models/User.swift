//
//  User.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import Foundation
import SwiftData

@Model
final class UserModel {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let email: String
    let usualFullName: String
    let image: UserImage
    let correctionPoint: Int
    let location: String?
    let wallet: Int
    let cursusUsers: [CursusUser]
    let projectsUsers: [ProjectUser]
    //let languagesUsers: [LanguagesUser]
    //let campus: [Campus]
    //let campusUsers: [CampusUser]

    enum CodingKeys: String, CodingKey {
        case id, login, email
        case usualFullName = "usual_full_name"
        case image
        case correctionPoint = "correction_point"
        case location, wallet
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
       // case languagesUsers = "languages_users"
       // case campus
       // case campusUsers = "campus_users"
    }
}

// MARK: - Image
struct UserImage: Codable {
    let link: String
    let versions: Versions
}

// MARK: - Versions
struct Versions: Codable {
    let large, medium, small: String
    let micro: String
}
