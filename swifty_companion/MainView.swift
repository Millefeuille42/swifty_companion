//
//  MainView.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI

struct MainView: View {
    @State var viewModel = ViewModel()
    let onLogout: () -> Void
    
    var body: some View {
        BottomBar(tabs: [
            Tab(
                title: "Me",
                iconName: "person.crop.circle",
                content: AnyView(ProfileView(login: "me"))
            ),
            Tab(
                title: "Search",
                iconName: "magnifyingglass.circle.fill",
                content: AnyView(ProfileView(login: "clafoutis"))
            ),
            Tab(
                title: "Settings",
                iconName: "gear",
                content: AnyView(VStack(
                    content: {
                        Button(
                            action: onLogout,
                            label: {
                                Text("Logout")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                )}))
            )
        ])
    }
}

extension MainView {
    @Observable
    class ViewModel {
        var errorMessage: String?
        
        init() {}
    }
}

#Preview {
    MainView(onLogout: {})
}
