//
//  PreviewConstants.swift
//  swifty_companion
//
//  Created by Millefeuille on 09/07/2024.
//

import Foundation
#if DEBUG

let previewSkill = Skill(
    id: 4,
    name: "Unix",
    level: 9.93
)

let previewProject = ProjectUser(
    id: 3467656,
    finalMark: Optional(0),
    status: "finished",
    validated: Optional(false),
    project: ProjectDigest(
        id: 2064,
        name: "Inception-of-Things",
        slug: "inception-of-things"
    ),
    cursusIds: [21],
    marked: Optional(true))

let previewCursus = CursusUser(
    id: 69791,
    grade: nil,
    level: Optional(8.53),
    skills: previewSkills,
    cursusID: 9,
    hasCoalition: true,
    user: UserDigest(
        id: 60070,
        login: "mlabouri",
        url: "https://api.intra.42.fr/v2/users/mlabouri"
    ),
    cursus: CursusDigest(
        id: 9,
        name: "C Piscine",
        slug: "c-piscine"
    )
)

let previewUser = User(
    id: 0,
    login: "someone",
    email: "someone@42.fr",
    usualFullName: "Some one",
    image: UserImage(link:"https://thispersondoesnotexist.com/"),
    correctionPoint: 4,
    location: "Here",
    wallet: 20000,
    cursusUsers: previewCursuses,
    projectsUsers: previewProjects
)

let previewSkills = [previewSkill, swifty_companion.Skill(id: 1, name: "Algorithms & AI", level: 6.55), swifty_companion.Skill(id: 14, name: "Adaptation & creativity", level: 5.58), swifty_companion.Skill(id: 3, name: "Rigor", level: 5.26), swifty_companion.Skill(id: 7, name: "Group & interpersonal", level: 0.39)]

let previewProjects = [previewProject, swifty_companion.ProjectUser(id: 3409581, finalMark: Optional(125), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1405, name: "darkly", slug: "42cursus-darkly"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 3467687, finalMark: nil, status: "in_progress", validated: nil, project: swifty_companion.ProjectDigest(id: 1446, name: "boot2root", slug: "42cursus-boot2root"), cursusIds: [21], marked: Optional(false)), swifty_companion.ProjectUser(id: 3409580, finalMark: nil, status: "in_progress", validated: nil, project: swifty_companion.ProjectDigest(id: 1395, name: "swifty-companion", slug: "42cursus-swifty-companion"), cursusIds: [21], marked: Optional(false)), swifty_companion.ProjectUser(id: 3409579, finalMark: nil, status: "in_progress", validated: nil, project: swifty_companion.ProjectDigest(id: 1379, name: "ft_hangouts", slug: "42cursus-ft_hangouts"), cursusIds: [21], marked: Optional(false)), swifty_companion.ProjectUser(id: 3072854, finalMark: Optional(125), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1404, name: "snow-crash", slug: "42cursus-snow-crash"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 2813855, finalMark: Optional(100), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1324, name: "Exam Rank 06", slug: "exam-rank-06"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 2689122, finalMark: Optional(100), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1337, name: "ft_transcendence", slug: "ft_transcendence"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 2679425, finalMark: Optional(100), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1323, name: "Exam Rank 05", slug: "exam-rank-05"), cursusIds: [21], marked: Optional(true))]

let previewCursuses = [previewCursus, swifty_companion.CursusUser(id: 75048, grade: Optional("Member"), level: Optional(15.04), skills: [swifty_companion.Skill(id: 16, name: "Company experience", level: 10.61), swifty_companion.Skill(id: 4, name: "Unix", level: 9.34), swifty_companion.Skill(id: 3, name: "Rigor", level: 8.62), swifty_companion.Skill(id: 7, name: "Group & interpersonal", level: 6.87), swifty_companion.Skill(id: 10, name: "Network & system administration", level: 6.83), swifty_companion.Skill(id: 6, name: "Web", level: 6.67), swifty_companion.Skill(id: 17, name: "Object-oriented programming", level: 5.96), swifty_companion.Skill(id: 11, name: "Security", level: 5.19), swifty_companion.Skill(id: 2, name: "Imperative programming", level: 4.88), swifty_companion.Skill(id: 1, name: "Algorithms & AI", level: 4.26), swifty_companion.Skill(id: 14, name: "Adaptation & creativity", level: 4.17), swifty_companion.Skill(id: 5, name: "Graphics", level: 3.21)], cursusID: 21, hasCoalition: true, user: swifty_companion.UserDigest(id: 60070, login: "mlabouri", url: "https://api.intra.42.fr/v2/users/mlabouri"), cursus: swifty_companion.CursusDigest(id: 21, name: "42cursus", slug: "42cursus")), swifty_companion.CursusUser(id: 212686, grade: nil, level: Optional(0.0), skills: [], cursusID: 67, hasCoalition: true, user: swifty_companion.UserDigest(id: 60070, login: "mlabouri", url: "https://api.intra.42.fr/v2/users/mlabouri"), cursus: swifty_companion.CursusDigest(id: 67, name: "42 events", slug: "42-events"))]

#endif
