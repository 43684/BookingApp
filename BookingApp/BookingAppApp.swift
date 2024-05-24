//
//  BookingAppApp.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-03.
//

import SwiftUI
import Firebase

@main
struct BookingAppApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AdminView()
        }
    }
}
