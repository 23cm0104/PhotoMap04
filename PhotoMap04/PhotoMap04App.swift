//
//  PhotoMap04App.swift
//  PhotoMap04
//
//  Created by cmStudent on 2024/06/12.
//

import SwiftUI

@main
struct PhotoMap04App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
