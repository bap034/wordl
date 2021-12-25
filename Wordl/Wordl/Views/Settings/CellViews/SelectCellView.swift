//
//  SelectCellView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import SwiftUI

struct SelectCellView: View {
    
    @State var titleText: String?
    @State var descriptionText: String?
    @State var isSelected: Bool
    var onTapped: (()->Void)?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let sureTitle = titleText {
                    Text(sureTitle)
                        .font(.system(size: 16, weight: .medium))
                }
                if let sureDescription = descriptionText {
                    Text(sureDescription)
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(Color.gray)
                }
            }
            
            Spacer()
            
            Toggle(isOn: $isSelected, label: {
                Image(systemName: "checkmark").imageScale(.large)
            })
                .toggleStyle(.button)
                .foregroundColor(isSelected ? .black : .white)
                .tint(.white)
        }
        .padding([.leading, .trailing])
        .contentShape(Rectangle())
        .onTapGesture {
//            withAnimation {
                isSelected.toggle()
                onTapped?()                
//            }
        }
//        Divider()
    }
}

struct SettingsStandardCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            let titleText = "title"
            let descriptionText = "This is a really long description to see what it looks like with the checkmark also enabled."
            SelectCellView(titleText: titleText, descriptionText: "descriptionText", isSelected: true)
            SelectCellView(titleText: titleText, descriptionText: "descriptionText", isSelected: false)
            
            SelectCellView(titleText: titleText, descriptionText: nil, isSelected: true)
            SelectCellView(titleText: titleText, descriptionText: nil, isSelected: false)
            
            SelectCellView(titleText: nil, descriptionText: descriptionText, isSelected: true)
            SelectCellView(titleText: nil, descriptionText: descriptionText, isSelected: false)
            
            SelectCellView(titleText: nil, descriptionText: nil, isSelected: true)
            SelectCellView(titleText: nil, descriptionText: nil, isSelected: false)
        }
    }
}
