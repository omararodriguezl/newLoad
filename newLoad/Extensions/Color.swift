//
//  Color.swift
//  newLoad
//
//  Created by Omar Rodriguez on 12/9/22.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}
struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgrounColor = Color ("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}
