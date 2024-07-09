//
//  Projects.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import SwiftUI


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
    Projects(
        projects: previewProjects,
        title: "Projects"
    )
}
