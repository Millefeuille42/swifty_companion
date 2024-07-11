//
//  TitleHeader.swift
//  swifty_companion
//
//  Created by Millefeuille on 11/07/2024.
//

import SwiftUI

struct TitleHeader: View {
    var body: some View {
        HStack{
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.horizontal, 20)
            VStack(alignment: .leading){
                Text(
                    "\(ConfigHelper.shared.appName()) v\(ConfigHelper.shared.appVersion())"
                )
                .foregroundColor(.gray)
                .font(.footnote)
                Text(
                    "by Millefeuille"
                )
                .foregroundColor(.gray)
                .font(.footnote)
            }
        }
    }
}

#Preview {
    TitleHeader()
}
