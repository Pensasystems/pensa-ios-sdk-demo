//
// PublicRepoAppApp.swift
// PublicRepoApp
//
// Copyright (c) 2024 by Pensa Systems, Inc. -- All rights reserved
// Confidential and Proprietary
//

import SwiftUI
import PensaSdk

@main
struct PublicRepoAppApp: App {
    init() {
        
        let clientId = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as! String
        let clientSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as! String
        
        Pensa.shared.enableLogging()
        Pensa.shared.initPensa(clientId: clientId, clientSecret: clientSecret) { error in
            if let error {
                print("Error on initializing Pensa SDK: \(error)")
            } else {
                print("Pensa SDK is ready to start!!")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
