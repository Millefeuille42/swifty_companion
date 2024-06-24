//
//  BottomBar.swift
//  swify_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI

struct Tab: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let content: AnyView
}

struct BottomBar: View {
    let tabs: [Tab]
    
    var body: some View {
        TabView {
            ForEach(tabs) { tab in
                tab.content
                    .tabItem {
                        Image(systemName: tab.iconName)
                        Text(tab.title)
                    }
            }
        }
    }
}

#Preview {
    BottomBar(tabs: [
        Tab(title: "Favourites", iconName: "heart.fill", content: AnyView(Text("Favourites Screen"))),
        Tab(title: "Friends", iconName: "person.fill", content: AnyView(Text("Friends Screen"))),
        Tab(title: "Nearby", iconName: "mappin.circle.fill", content: AnyView(Text("Nearby Screen")))
    ])
}
