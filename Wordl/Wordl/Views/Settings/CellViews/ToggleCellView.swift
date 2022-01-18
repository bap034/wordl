//
//  ToggleCellView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/25/21.
//

import SwiftUI

struct ToggleCellView: View {
    @State var titleText: String?
    @State var descriptionText: String?
    @State var isOn: Bool
    var onToggled: ((Bool)->Void)?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let sureTitle = titleText {
                    Text(sureTitle)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(StyleGuide.Color.primary)
                    
                }
                if let sureDescription = descriptionText {
                    Text(sureDescription)
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(StyleGuide.Color.secondary)
                }
            }
            
            Spacer()
            
            Toggle(isOn: $isOn, label: {})
                .labelsHidden()
                .onChange(of: isOn) { newValue in
                    onToggled?(newValue)
                }
        }
        .padding([.leading, .trailing])
        .contentShape(Rectangle())
        .onTapGesture {
//            withAnimation {
                isOn.toggle()
                onToggled?(isOn)                
//            }
        }
        .background(StyleGuide.Color.background)
//        Divider()
    }
}

struct ToggleCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToggleCellView(titleText: "Title text", isOn: true)
            ToggleCellView(isOn: false)
        }
    }
}
