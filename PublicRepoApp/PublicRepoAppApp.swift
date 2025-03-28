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
        
        let config = PensaConfiguration.Builder()
            .setClientId(clientId)
            .setClientSecret(clientSecret)
            .setLoggingEnabled(true)
            .setScanUploadListener(self)
            .setCantScanEventListener(self)
            .build()
        
        Pensa.shared.initPensa(config: config) { error in
            if let error = error {
                print("Error initializing Pensa SDK: \(error)")
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

extension PublicRepoAppApp: ScanUploadListener, CantScanEventListener {
    func onScanUploadProgressUpdate(tdlinxId: String, scanAreaId: String, progress: Double) {
        print("onScanUploadProgressUpdate() -> tdlinxId: \(tdlinxId), scanAreaId: \(scanAreaId) process: \(progress)")
    }
    
    func onScanUploadCompleted(tdlinxId: String, scanAreaId: String) {
            print("onScanUploadCompleted() -> Upload completed successfully tdlinxId: \(tdlinxId), scanAreaId: \(scanAreaId)")
    }
    
    func onScanUploadFailed(tdlinxId: String, scanAreaId: String, error: CallbackError) {
        print("onScanUploadFailed() -> Upload failed for tdlinxId: \(tdlinxId), scanAreaId: \(scanAreaId) Error Code: \(error.code.rawValue), Message: \(error.message)")
    }
    
    func onCantScanReported(tdlinxId: String, scanAreaId: String, cantScanReason: String) {
        print("onCantScanReported() -> tdlinxId: \(tdlinxId), scanAreaId: \(scanAreaId) cantScanReason: \(cantScanReason)")
    }
}
