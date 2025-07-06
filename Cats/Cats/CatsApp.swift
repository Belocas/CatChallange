//
//  CatsApp.swift
//  Cats
//
//  Created by Isabel Couto on 04/07/2025.
//

import SwiftUI

@main
struct CatsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CatsListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
