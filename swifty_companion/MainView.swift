//
//  MainView.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI

struct MainView: View {
    let onLogout: () -> Void
    
    var body: some View {
        BottomBar(tabs: [
            Tab(
                title: "Profile",
                iconName: "person.crop.circle",
                content: AnyView(SearchView())
            ),
            Tab(
                title: "Settings",
                iconName: "gear",
                content: AnyView(SettingsView(onLogout: onLogout))
            )
        ])
    }
}

#Preview {
    MainView(onLogout: {})
}
