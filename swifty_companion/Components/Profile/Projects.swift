//
//  Projects.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import SwiftUI

let defaultProjects = [swifty_companion.ProjectUser(id: 3467656, finalMark: Optional(0), status: "finished", validated: Optional(false), project: swifty_companion.ProjectDigest(id: 2064, name: "Inception-of-Things", slug: "inception-of-things"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 3409581, finalMark: Optional(125), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1405, name: "darkly", slug: "42cursus-darkly"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 3467687, finalMark: nil, status: "in_progress", validated: nil, project: swifty_companion.ProjectDigest(id: 1446, name: "boot2root", slug: "42cursus-boot2root"), cursusIds: [21], marked: Optional(false)), swifty_companion.ProjectUser(id: 3409580, finalMark: nil, status: "in_progress", validated: nil, project: swifty_companion.ProjectDigest(id: 1395, name: "swifty-companion", slug: "42cursus-swifty-companion"), cursusIds: [21], marked: Optional(false)), swifty_companion.ProjectUser(id: 3409579, finalMark: nil, status: "in_progress", validated: nil, project: swifty_companion.ProjectDigest(id: 1379, name: "ft_hangouts", slug: "42cursus-ft_hangouts"), cursusIds: [21], marked: Optional(false)), swifty_companion.ProjectUser(id: 3072854, finalMark: Optional(125), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1404, name: "snow-crash", slug: "42cursus-snow-crash"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 2813855, finalMark: Optional(100), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1324, name: "Exam Rank 06", slug: "exam-rank-06"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 2689122, finalMark: Optional(100), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1337, name: "ft_transcendence", slug: "ft_transcendence"), cursusIds: [21], marked: Optional(true)), swifty_companion.ProjectUser(id: 2679425, finalMark: Optional(100), status: "finished", validated: Optional(true), project: swifty_companion.ProjectDigest(id: 1323, name: "Exam Rank 05", slug: "exam-rank-05"), cursusIds: [21], marked: Optional(true))]

struct Project: View {
    let project: ProjectUser
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(project.status == "in_progress" ? "🚧" : project.validated == true ? "✅" : "❌")
                Text(project.project.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                if project.finalMark != nil {
                    Text("\(project.finalMark ?? 0)")
                }
            }
        }
    }
}

struct Projects: View {
    let projects: [ProjectUser]
    let title: String
    @State var isExpanded = true
    
    var body: some View {
        DisclosureGroup(title, isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(projects) { project in
                    Project(project: project)
                }
            }.padding(.vertical)
        }
    }
}

#Preview {
    Projects(projects: defaultProjects, title: "Projects")
}
