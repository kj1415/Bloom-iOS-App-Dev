//
//  LoginApp.swift
//  Login
//
//  Created by user1 on 26/12/23.
//

import SwiftUI
import Firebase
@main
struct LoginApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            onboarding()
        }
    }
}



