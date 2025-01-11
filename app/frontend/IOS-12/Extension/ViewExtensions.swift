//
//  ViewExtensions.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.11.24.
//

import SwiftUI
import UIKit

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
