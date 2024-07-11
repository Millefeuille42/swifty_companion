//
//  SettingsView.swift
//  swifty_companion
//
//  Created by Millefeuille on 10/07/2024.
//

import SwiftUI

struct SettingsView: View {
    let onLogout: () -> Void
    @State private var presentAlert = false
    
    var body: some View {
        NavigationView {
            VStack{
                TitleHeader()
                List() {
                    NavigationLink(
                        destination: WebView(url: URL(string: "https://github.com/Millefeuille42/swifty_companion")),
                        label: {
                            Label("See source on Github", systemImage: "swift")
                                .labelStyle(.titleAndIcon)
                                .frame(height: 32)
                                .foregroundColor(.blue)
                    })
                    NavigationLink(
                        destination: WebView(url: URL(string: "https://ko-fi.com/millefeuille42")),
                        label: {
                            Label("Buy me a coffee", systemImage: "cup.and.saucer.fill")
                                .labelStyle(.titleAndIcon)
                                .frame(height: 32)
                                .foregroundColor(.blue)
                    })
                    Button(
                        action: { presentAlert = true },
                        label: {
                            Label("Logout", systemImage: "delete.left.fill")
                                .labelStyle(.titleAndIcon)
                                .frame(height: 32)
                                .foregroundColor(.red)
                        }
                    )
                }.environment(\.defaultMinListRowHeight, 32)
                .confirmationDialog(
                    "Logging out",
                    isPresented: $presentAlert
                ) {
                    Button("Logout", role: .destructive) {
                        onLogout()
                    }
                } message: {
                    Text("Are you sure you want to log out?")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView(onLogout: {})
}
