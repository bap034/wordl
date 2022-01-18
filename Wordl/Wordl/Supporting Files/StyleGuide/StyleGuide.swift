//
//  StyleGuide.swift
//  Wordl
//
//  Created by Brett Petersen on 1/15/22.
//

import SwiftUI

struct StyleGuide {
    struct Color {
        static let background =    SwiftUI.Color("background")
        static let primary =       SwiftUI.Color("primary")
        static let secondary =     SwiftUI.Color("secondary")
        static let accent =        SwiftUI.Color("accent")
        
        struct Feedback {
            static let normal =    StyleGuide.Color.primary
            static let unused =    StyleGuide.Color.primary
            static let correct =   SwiftUI.Color("correct")
            static let wrongSpot = SwiftUI.Color("wrongSpot")
        }
    }
}
