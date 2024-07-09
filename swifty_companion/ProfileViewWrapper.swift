//
//  ProfileViewWrapper.swift
//  swifty_companion
//
//  Created by Millefeuille on 09/07/2024.
//

import SwiftUI

struct ProfileViewWrapper: View {
    @StateObject var viewModel: ViewModel

    init(login: String) {
        _viewModel = StateObject(wrappedValue: ViewModel(login))
    }
    
    var body: some View {
        if viewModel.errorMessage != nil {
            VStack{
                Text("Unable to display profile")
                    .foregroundColor(.red)
                Text(viewModel.errorMessage ?? "Error")
                    .foregroundColor(.red)
            }
        }
        else if viewModel.user != nil {
            ProfileView(user: viewModel.user!)
        } else {
            ProgressView()
        }
    }
}

extension ProfileViewWrapper {
    class ViewModel: ObservableObject {
        @Published var user: User?
        @Published var errorMessage: String?
        
        init(_ login: String) {
            fetchUser(login)
        }
        
        func fetchUser(_ login: String) {
            FtApiClient.shared.fetchUser(login) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        self.user = user
                    case .failure(let error):
                        switch error {
                        case FtApiClient.ApiError.notFound:
                            self.errorMessage = "User not found"
                        default:
                            self.errorMessage = "Failed to fetch user: \(error)"
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileViewWrapper(login: "tefroiss")
}
