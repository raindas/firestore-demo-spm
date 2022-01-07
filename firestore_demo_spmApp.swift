//
//  firestore_demo_spmApp.swift
//  firestore-demo-spm
//
//  Created by President Raindas on 07/01/2022.
//

import SwiftUI
import Firebase

@main
struct firestore_demo_spmApp: App {
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
