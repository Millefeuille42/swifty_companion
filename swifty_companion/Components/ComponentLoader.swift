//
//  ComponentLoader.swift
//  swifty_companion
//
//  Created by Millefeuille on 21/06/2024.
//

import SwiftUI

struct ComponentLoader<Content: View, Loader: View>: View {
    let predicate: Bool
    let content: Content
    let loader: Loader
    
    init(predicate: Bool, @ViewBuilder content: () -> Content, @ViewBuilder loader: () -> Loader) {
        self.predicate = predicate
        self.content = content()
        self.loader = loader()
    }
    
    var body: some View {
        if predicate {
            content
        } else {
            loader
        }
    }
}
