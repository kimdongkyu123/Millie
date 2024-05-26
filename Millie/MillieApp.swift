//
//  MillieApp.swift
//  Millie
//
//  Created by DK on 5/23/24.
//

import SwiftUI

@main
struct MillieApp: App {
    
    @StateObject private var navigationRouter: NavigationRouter = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationRouter)
        }
    }
}
