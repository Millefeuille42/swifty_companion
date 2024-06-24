//
//  ProfilePicture.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import SwiftUI

struct ProfilePicture: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(
            url: url
        ) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .clipShape(Circle()
        )
        .frame(width: 100, height: 100)
    }
}

#Preview {
    ProfilePicture(url: URL(string: "https://thispersondoesnotexist.com/"))
}
