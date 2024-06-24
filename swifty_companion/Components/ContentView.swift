//
//  ContentView.swift
//  swify_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("Hello world")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
