//
// MenuItemView.swift
// PublicRepoApp
//
// Copyright (c) 2024 by Pensa Systems, Inc. -- All rights reserved
// Confidential and Proprietary
//

import SwiftUI

struct MenuItemView: View {
    let text: String
    let image: String
    let onTap: () -> Void

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(text)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.system(size: 14))
        }
        .frame(width: 120, height: 100)
        .padding()
        .background(.white)
        .cornerRadius(8)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    MenuItemView(text: "Search Stores", image: "search_store", onTap: {})
}
