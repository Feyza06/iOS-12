//
//  FullScreenImageView.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.11.24.
//

import SwiftUI

struct FullScreenImageView: View {
    let imageName: String
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .onTapGesture {
            isPresented = false
        }
    }
}
