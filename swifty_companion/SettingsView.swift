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
        VStack{
            Button(
                action: { presentAlert = true },
                label: {
                    Text("Logout")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            )
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
//            .alert(isPresented: $presentAlert) {
//                Alert(
//                    title: Text("Logging out"),
//                    message: Text("Are you sure you want to log out?"),
//                    primaryButton: .destructive(Text("Logout")) {
//                        onLogout()
//                    },
//                    secondaryButton: .cancel()
//                )
//            }
        }
    }
}

#Preview {
    SettingsView(onLogout: {})
}
