//
//  Trainocate_swiftUIApp.swift
//  Trainocate-swiftUI
//
//  Created by 大空太陽 on 6/10/21.
//

import SwiftUI

@main
struct Trainocate_swiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PostsDataObvObj())
        }
    }
}
