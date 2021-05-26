//
//  PAPAY_SwiftApp.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 5/26/21.
//

import SwiftUI

@main
struct PAPAY_SwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
