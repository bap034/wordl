//
//  KeyboardKeyView.swift
//  Wordl
//
//  Created by Brett Petersen on 1/2/22.
//

import SwiftUI

struct KeyboardKeyView: View {
    
    var keyText: String
    var keyFeedbackType: KeyboardKeyFeedbackType
    var onTap: (()->Void)?
    
    var body: some View {
        /// Font sizing source: https://stackoverflow.com/a/59093286
        GeometryReader { g in
            let width = g.size.width
            let height = g.size.height
            let cornerLength = min(width, height) * 0.10
            let sidePadding = width * 0.1
            let fontSize = min(width, height) - (2*sidePadding)
            let strokeWidth = fontSize * 0.05
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: cornerLength, height: cornerLength))
                    .foregroundColor(getKeyBackgroundColor())
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: cornerLength, height: cornerLength))
                            .stroke(getKeyBorderColor(), lineWidth: strokeWidth)
                    )
                
                Text(keyText)
                    .foregroundColor(getKeyTextColor())
                    .fontWeight(.light)
                    .font(.system(size: fontSize))
                    .minimumScaleFactor(0.001)
                    .padding([.leading, .trailing], sidePadding)
                    .padding([.top, .bottom], width * 0.02)
                    .onTapGesture {
                        onTap?()
                    }
            }
        }
    }
}

extension KeyboardKeyView {
    private func getKeyBackgroundColor() -> Color {
        let color: Color
        switch keyFeedbackType {
            case .spacer:
                color = .clear
            case .normal:
                color = StyleGuide.Color.primary
            case .correct:
                color = .teal
            case .wrongSpot:
                color = .orange
            case .unused:
                color = .clear
        }
        return color
    }
    
    private func getKeyBorderColor() -> Color {
        let color: Color
        switch keyFeedbackType {
            case .spacer:
                color = .clear
            case .normal:
                color = .clear
            case .correct:
                color = .clear
            case .wrongSpot:
                color = .clear
            case .unused:
                color = StyleGuide.Color.primary
        }
        return color
    }
    
    private func getKeyTextColor() -> Color {
        let color: Color
        switch keyFeedbackType {
            case .spacer:
                color = .clear
            case .normal:
                color = StyleGuide.Color.accent
            case .correct:
                color = StyleGuide.Color.accent
            case .wrongSpot:
                color = StyleGuide.Color.accent
            case .unused:
                color = StyleGuide.Color.primary
        }
        return color
    }
}

struct KeyboardKeyView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            KeyboardKeyView(keyText: "Q", keyFeedbackType: .normal)
            KeyboardKeyView(keyText: "W", keyFeedbackType: .unused)
            KeyboardKeyView(keyText: "E", keyFeedbackType: .wrongSpot)
            KeyboardKeyView(keyText: "R", keyFeedbackType: .correct)
            KeyboardKeyView(keyText: "", keyFeedbackType: .spacer)
            KeyboardKeyView(keyText: "ENTERRRR", keyFeedbackType: .normal)
        }
        .padding()
    }
}
