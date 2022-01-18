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
    
    var keys: [KeyboardKey]
    private var topRowKeys: [KeyboardKey] { keys.filter({ $0.rowType == .top }) }
    private var midRowKeys: [KeyboardKey] { keys.filter({ $0.rowType == .mid }) }
    private var botRowKeys: [KeyboardKey] { keys.filter({ $0.rowType == .bot }) }
    
    var onKeyTapped: ((KeyboardKey)->Void)?
    
    var body: some View {
        GeometryReader { (geometry) in
            let keyLength: CGFloat = max((geometry.size.width / CGFloat(largestRowKeyCount)) - spacing, 0)
            
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
                let keyMinWidth: CGFloat = keyLength
                let keyMaxWidth: CGFloat? = (key.sizeType == .fixed) ? keyLength : keyLength*2
                let keyHeight = keyLength * 1.5
                
                KeyboardKeyView(keyText: key.type.displayText, keyFeedbackType: key.feedbackType, onTap: {
                    onKeyTapped?(key)
                })
                    .frame(minWidth: keyMinWidth, maxWidth: keyMaxWidth, minHeight: keyHeight, maxHeight: keyHeight)
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(keys: KeyboardManager.shared.keys) { keyboardKey in
            print("\(keyboardKey.type.displayText) tapped")
        }
    }
}
