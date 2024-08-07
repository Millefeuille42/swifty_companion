//
//  LoginView.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            if viewModel.errorMessage != nil {
                TitleHeader()
                Text(viewModel.errorMessage ?? "Error")
                    .foregroundColor(.red)
            } else if viewModel.isAuthenticated {
                MainView(onLogout: viewModel.handleLogout)
            } else {
                TitleHeader()
                Divider()
                NavigationView {
                    NavigationLink(
                        destination: WebView(url: viewModel.authorizationUrl, onCustomLink: viewModel.handleCallback),
                        label: {
                            Text("Login with OAuth")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                    })
                }.padding(.bottom, 100)
            }
        }
        .alert(isPresented: $viewModel.presentAlert, content: {
            Alert(
                title: Text("You have been logged out"),
                message: Text("Please log back in to continue to use the app")
            )
        })
    }
}

extension LoginView {
    @Observable
    class ViewModel {
        var isAuthenticated: Bool = false
        var authorizationUrl: URL?
        var errorMessage: String?
        var presentAlert: Bool = false
        
        init() {
            initSelf()
        }
        
        private func initSelf() {
            FtApiClient.shared.onLogout {
                self.presentAlert = true
                self.handleLogout()
            }
            self.isAuthenticated = FtApiClient.shared.isAuthenticated()
            if (self.isAuthenticated) { return }
                
            do {
                self.authorizationUrl = try FtApiClient.shared.authorizeUrl()
            } catch KeychainHelper.KeychainError.unhandledError(let status, let context) {
                self.errorMessage = "Failed to interact with keychain storage: \(status) (\(context ?? "no context"))"
            } catch (let error) {
                self.errorMessage = "Failed to generate authorization URL: \(error)"
            }
        }
        
        func handleLogout() {
            try? FtApiClient.shared.logout()
            initSelf()
        }
        
        func handleCallback(url: URL) {
            do {
                try FtApiClient.shared.handleCallback(url: url)
                fetchAccessToken()
            } catch (let error) {
                self.errorMessage = "Failed to handle callback: \(error)"
            }
        }
        
        private func fetchAccessToken() {
            FtApiClient.shared.fetchAccessTokenCode() { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.isAuthenticated = true
                    case .failure(let error):
                        self.handleLogout()
                        self.errorMessage = "Failed to fetch access token: \(error)"
                    }
                }
            }
        }
    }
}


#Preview {
    LoginView()
}
