//
//  SearchView.swift
//  swifty_companion
//
//  Created by Millefeuille on 09/07/2024.
//

import SwiftUI
import Combine

struct SearchView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack() {
                if (viewModel.searchText == "") {
                    ProfileViewWrapper(login: "me")
                }
                else if (viewModel.searchText != viewModel.debouncedSearchText) {
                    ProgressView()
                } else {
                    ProfileViewWrapper(
                        login: viewModel.debouncedSearchText.lowercased()
                    )
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a student")
        .disableAutocorrection(true)
        .autocapitalization(.none)
    }
}

extension SearchView {
    class ViewModel: ObservableObject {
        @Published var searchText = ""
        @Published var debouncedSearchText = ""
        
        init() {
            setupSearchTextDebounce()
        }
        
        func setupSearchTextDebounce() {
            debouncedSearchText = searchText
            $searchText
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .assign(to: &$debouncedSearchText)
        }
    }
}

#Preview {
    SearchView()
}
