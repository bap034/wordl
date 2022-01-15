//
//  KeyboardKeyView.swift
//  Wordl
//
//  Created by Brett Petersen on 1/2/22.
//

import SwiftUI

struct KeyboardKeyView: View {
    
    @State var keyText: String
    @State var keyFeedbackType: KeyboardKeyFeedbackType
    var onTap: (()->Void)?
    
    var body: some View {
        /// Font sizing source: https://stackoverflow.com/a/59093286
        GeometryReader{ g in
            let width = g.size.width
            let height = g.size.height
            let cornerLength = min(width, height) * 0.10
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: cornerLength, height: cornerLength))
                    .foregroundColor(getKeyColor())
                
                Text(keyText)
                    .foregroundColor(.black)
                    .fontWeight(.light)
                    .padding([.leading, .trailing], width * 0.05)
                    .padding([.top, .bottom], width * 0.02)
                    .font(.system(size: height > width ? width * 1: height * 1))
                    .minimumScaleFactor(0.001)
                    .onTapGesture {
                        onTap?()
                    }
            }
        }
    }
}

extension KeyboardKeyView {
    private func getKeyColor() -> Color {
        let color: Color
        switch keyFeedbackType {
            case .normal:
                color = .gray
            case .correct:
                color = .teal
            case .wrongSpot:
                color = .orange
            case .unused:
                color = .red
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
            KeyboardKeyView(keyText: "ENTERRRR", keyFeedbackType: .normal)
        }
        .padding()
    }
}
