//
//  Skills.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import SwiftUI

struct Skills: View {
    let skills: [Skill] 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Skills").font(.headline)
            ForEach(skills) { skill in
                ProgressView(
                    value: (skill.level + 0.001) / 10,
                    label: { Text(skill.name) },
                    currentValueLabel: { Text(String(format: "%.2f%%", skill.level)) }
                )
            }
        }.padding()
    }
}

#Preview {
    Skills(
        skills: previewSkills
    )
}
