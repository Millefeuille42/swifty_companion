//
//  HomeView.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI


struct ProfileView: View {
    let user: User
    @State var viewModel: ViewModel
    
    init(user: User) {
        self.user = user
        _viewModel = State(wrappedValue: ViewModel(user))
    }
    
    var body: some View {
        ScrollView {
            VStack{
                ProfilePicture(
                    url: URL(string: viewModel.user.image.link)
                )
                
                HStack {
                    if viewModel.cursus != nil { Text(viewModel.cursus?.grade ?? "") }
                    Text(viewModel.user.login)
                        .font(.headline)
                }
                
                Picker("Cursus", selection: $viewModel.selectedCursus) {
                    ForEach(viewModel.user.cursusUsers, id: \.id) { cursus in
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
                
                Picker("Options", selection: $viewModel.selectedSection) {
                    Text("Projects").tag("projects")
                    Text("Skills").tag("skills")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if (viewModel.selectedSection == "projects") {
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
                } else {
                    if viewModel.cursus?.skills != nil && !viewModel.cursus!.skills.isEmpty {
                        Skills(skills: viewModel.cursus!.skills)
                    }
                    Spacer()
                }
                //TODO Coalition stuff
            }
        }
    }
}

extension ProfileView {
    @Observable
    class ViewModel {
        var errorMessage: String?
        var user: User
        var cursus: CursusUser?
        var selectedCursus: Int = 0
        var selectedSection: String = "projects"
        
        init(_ user: User) {
            self.user = user
            self.selectedCursus = self.user.cursusUsers.first(where: { $0.cursus.slug == "42cursus" })?.id ?? 0
            if self.selectedCursus == 0 {
                self.selectedCursus = self.user.cursusUsers.first?.id ?? 0
            }
            self.getSelectedCursus()
        }
        
        private func getSelectedCursus() {
            self.cursus = self.user.cursusUsers.first(where: { $0.id == selectedCursus
            })
        }
        
        func getProjectsOfCursus() -> [ProjectUser] {
            let currentCursus = self.user.cursusUsers.first(where: { $0.id == self.selectedCursus })?.cursusID ?? 0
            return self.user.projectsUsers.filter { return $0.cursusIds.contains(currentCursus) }
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

var defaultUser: User = User(id: 0, login: "someone", email: "jesuisunmail@mail", usualFullName: "Some one", image: UserImage(link:"https://thispersondoesnotexist.com/"), correctionPoint: 4, location: "Here", wallet: 20000, cursusUsers: [], projectsUsers: [])

#Preview {
    ProfileView(user: defaultUser)
}
