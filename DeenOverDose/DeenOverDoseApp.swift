//
//  DeenOverDoseApp.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-15.
//

import SwiftUI

@main
struct DeenOverDoseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
