//
//  ProfileCard.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import SwiftUI

struct ProfileCard: View {
    let user: User
    let cursus: CursusUser?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(user.usualFullName).font(.headline)
                Spacer()
                Text(user.location ?? "Offline")
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                    .frame(alignment: .trailing)
                    .background(user.location == nil ? .red : .blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            ProgressView(
                value: modf(cursus?.level ?? 0).1,
                label: { },
                currentValueLabel: { Text(String(format: "%.2f%%", cursus?.level ?? 0)) }
            )
            
            Text(user.email)
            Text("\(user.correctionPoint) Correction point\((user.correctionPoint) > 1 ? "s" : "")")
                
            Text("\(user.wallet) ₳")
        }.padding()
    }
}


#Preview {
    ProfileCard(
        user: previewUser,
        cursus: nil
    )
}
