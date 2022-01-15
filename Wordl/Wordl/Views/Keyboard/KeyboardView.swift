//
//  KeyboardView.swift
//  Wordl
//
//  Created by Brett Petersen on 1/2/22.
//

import SwiftUI

struct KeyboardView: View {
    
    private let spacing: CGFloat = 7
    private var largestRowKeyCount: Int {
        let topRowCount = topRowKeys.count
        let midRowCount = midRowKeys.count
        let botRowCount = botRowKeys.count
        let largestRowCount = max(topRowCount, midRowCount, botRowCount)
        return largestRowCount
    }
    
    @State var topRowKeys = KeyboardManager.generateTopRowKeys()
    @State var midRowKeys = KeyboardManager.generateMidRowKeys()
    @State var botRowKeys = KeyboardManager.generateBotRowKeys()
    
    var onKeyTapped: ((KeyboardKey)->Void)?
    
    var body: some View {
        GeometryReader { (geometry) in
            let keyLength: CGFloat = (geometry.size.width / CGFloat(largestRowKeyCount)) - spacing
            
            VStack(spacing: spacing) {
                // Top Row
                generateKeyRow(keys: topRowKeys, keyLength: keyLength)
                
                // Mid Row
                generateKeyRow(keys: midRowKeys, keyLength: keyLength)
                
                // Bot Row
                generateKeyRow(keys: botRowKeys, keyLength: keyLength)
            }
        }
        .background(StyleGuide.Color.background)
    }
    
    func generateKeyRow(keys: [KeyboardKey], keyLength: CGFloat) -> some View {
        HStack(spacing: spacing) {
            ForEach(keys) { key in
                let keyWidth: CGFloat? = (key.sizeType == .fixed) ? keyLength : nil
                
                KeyboardKeyView(keyText: key.value, keyFeedbackType: key.feedbackType, onTap: {
                    onKeyTapped?(key)
                })
                    .frame(width: keyWidth, height: keyLength * 1.5)
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView { keyboardKey in
            print("\(keyboardKey.value) tapped")
        }
    }
}
