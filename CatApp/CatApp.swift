//
//  CatApp.swift
//  CatApp
//
//  Created by Gabriel on 03/02/25.
//

import SwiftUI

@main
struct CatApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CatListView()
            }
        }
    }
}
