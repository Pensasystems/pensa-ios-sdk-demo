//
// ContentView.swift
// PublicRepoApp
//
// Copyright (c) 2024 by Pensa Systems, Inc. -- All rights reserved
// Confidential and Proprietary
//

import AlertToast
import PensaSdk
import SwiftUI

struct ContentView: View {
    @State private var showLoginDialog = false
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var showTdlinxDialog = false
    @State private var tdlinxCode = ""
    @State private var sectionKey = ""
    @State private var guid = ""

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: .top),
        GridItem(.flexible(), spacing: 10, alignment: .top),
    ]

    var body: some View {
        ZStack(alignment: .center) { // Ensures alignment of all content
            Color(red: 95/255, green: 173/255, blue: 197/255)
                .edgesIgnoringSafeArea(.all)

            VStack {
                ScrollView {
                    Spacer().frame(height: 40)
                    Text("ShelfXpert")
                        .font(.system(size: 38))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    Spacer().frame(height: 40)
                    LazyVGrid(columns: columns, spacing: 10) {
                        MenuItemView(text: "Search Stores", image: "search_store") {
                            if !shouldInitPensa() {
                                Pensa.shared.displaySearchStore()     
                            }
                        }

                        MenuItemView(text: "Monitor Uploads", image: "monitor") {
                            if !shouldInitPensa() {
                                Pensa.shared.monitorUploads()
                            }
                        }
                        MenuItemView(text: "Recent Stores", image: "shop_sdk") {
                            if !shouldInitPensa() {
                                Pensa.shared.displayRecentlyVisitedStores()
                            }
                        }
                        MenuItemView(text: "Launch Store By GlobalStoreId", image: "scan") {
                            if !shouldInitPensa() {
                                showTdlinxDialog = true
                            }
                        }
                    }
                }
                .toast(isPresenting: $showToast) {
                    AlertToast(displayMode: .banner(.slide), type: .regular, title: toastMessage)
                }

                Spacer()

                Text("Copyright © Pensa Systems 2024")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .padding(.bottom, 16)
            }

            if showTdlinxDialog {
                // Add a semi-transparent background for the dialog
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showTdlinxDialog = false
                    }

                // Center the dialog
                VStack(spacing: 16) {
                    Text("Enter Store Details")
                        .foregroundColor(.black)
                        .font(.headline)

                    TextField("", text: $tdlinxCode, prompt: Text("GlobalStoreId").foregroundColor(.gray))
                        .foregroundColor(.black)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    TextField("", text: $sectionKey, prompt: Text("SectionKey (Optional)").foregroundColor(.gray))
                        .foregroundColor(.black)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    TextField("", text: $guid, prompt: Text("Guid (Optional)").foregroundColor(.gray))
                        .foregroundColor(.black)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)

                    HStack {
                        Button("Cancel") {
                            showTdlinxDialog = false
                        }
                        .foregroundColor(.red)
                        
                        Spacer()

                        Button("Submit") {
                            if !tdlinxCode.isEmpty {
                                Pensa.shared.displayStoreById(sectionKey: sectionKey.isEmpty ? nil : sectionKey,
                                                              guid: guid.isEmpty ? nil : guid,
                                                              globalStoreId: tdlinxCode,
                                                              onError: { error in
                                    
                                    toastMessage = error.localizedDescription
                                    showToast = true
                                    
                                })
                                showTdlinxDialog = false
                            } else {
                                toastMessage = "GlobalStoreId is required"
                                showToast = true
                            }
                        }
                        .disabled(tdlinxCode.isEmpty)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .frame(maxWidth: 300) // Optional width constraint for the dialog
                .padding(.horizontal, 40)
            }
        }
    }

    private func shouldInitPensa() -> Bool {
        if !Pensa.shared.isPensaStarted() {
            toastMessage = "Pensa is not configured"
            showToast = true
            return true
        } else {
            return false
        }
    }
}
