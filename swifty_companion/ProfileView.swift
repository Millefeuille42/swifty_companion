//
//  HomeView.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI



struct ProfileView: View {
    let login: String
    @State var viewModel: ViewModel
    
    init(login: String) {
        self.login = login
        _viewModel = State(wrappedValue: ViewModel(login))
    }
    
    
    var body: some View {
        if viewModel.errorMessage != nil {
            Text(viewModel.errorMessage ?? "Error")
                .foregroundColor(.red)
        } else if viewModel.user != nil {
            ScrollView {
                VStack{
                    ProfilePicture(
                        url: URL(string: viewModel.user!.image.link)
                    )
                    
                    HStack {
                        if viewModel.cursus != nil { Text(viewModel.cursus?.grade ?? "") }
                        Text(viewModel.user!.login)
                            .font(.headline)
                    }
                    
                    Picker("Cursus", selection: $viewModel.selectedCursus) {
                        ForEach(viewModel.user!.cursusUsers, id: \.id) { cursus in
                            Text(cursus.cursus.name)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: viewModel.selectedCursus) { oldState, newState in
                        viewModel.handleSelectCursus(oldState, newState)
                    }
                    Divider()
                    
                    ProfileCard(
                        user: viewModel.user,
                        cursus: viewModel.cursus
                    )
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Projects")
                            Spacer()
                        }
                        if !viewModel.getProjectsOfStatus(status: "in_progress").isEmpty {
                            Projects(projects: viewModel.getProjectsOfStatus(status: "in_progress"), title: "In Progress")
                        }
                        if !viewModel.getProjectsOfStatus(status: "finished").isEmpty {
                            Projects(projects: viewModel.getProjectsOfStatus(status: "finished"), title: "Finished")
                        }
                    }.padding()
                    
                    Divider()
                    
                    //TODO Coalition stuff
                    if viewModel.cursus?.skills != nil && !viewModel.cursus!.skills.isEmpty {
                        Skills(skills: viewModel.cursus!.skills)
                    }
                    Spacer()
                }
            }
        } else {
            ProgressView()
                .progressViewStyle(.circular)
        }
        
    }
}

extension ProfileView {
    @Observable
    class ViewModel {
        var errorMessage: String?
        var user: User?
        var cursus: CursusUser?
        var selectedCursus: Int = 0
        
        init(_ login: String) {
            self.fetchUser(login)
        }
        
        private func getSelectedCursus() {
            self.cursus = self.user?.cursusUsers.first(where: { $0.id == selectedCursus
            })
        }
        
        func fetchUser(_ login: String) {
            FtApiClient.shared.fetchUser(login) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        self.user = user
                        self.selectedCursus = self.user?.cursusUsers.first(where: { $0.cursus.slug == "42cursus" })?.id ?? 0
                        if self.selectedCursus == 0 {
                            self.selectedCursus = self.user?.cursusUsers.first?.id ?? 0
                        }
                        self.getSelectedCursus()
                    case .failure(let error):
                        // TODO logout user on failure
                        self.errorMessage = "Failed to fetch user: \(error)"
                    }
                }
            }
        }
        
        func getProjectsOfCursus() -> [ProjectUser] {
            let currentCursus = self.user?.cursusUsers.first(where: { $0.id == self.selectedCursus })?.cursusID ?? 0
            return self.user?.projectsUsers.filter { return $0.cursusIds.contains(currentCursus) } ?? []
        }
        
        func getProjectsOfStatus(status: String) -> [ProjectUser] {
            return self.getProjectsOfCursus().filter { return $0.status == status }
        }
        
        func handleSelectCursus(_ _: Int, _ selectedCursus: Int) {
            self.selectedCursus = selectedCursus
            self.getSelectedCursus()
        }
    }
}

#Preview {
    ProfileView(login: "tefroiss")
}
