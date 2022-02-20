//
//  BreakingBadApp.swift
//  Shared
//
//  Created by Salvador on 2/18/22.
//

import SwiftUI

@main
struct BreakingBadApp: App {
        
    var body: some Scene {
        WindowGroup {
            ZStack{
                HomeView()
                    .environmentObject(OrientationInfo())
            }
        }
    }
}
