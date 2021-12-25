//
//  SettingsStandardCellView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import SwiftUI

struct SettingsStandardCellView: View {
    
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
            
            if isSelected {
                Image(systemName: "checkmark").imageScale(.large)
            }
        }
        .padding([.leading, .trailing])
        .onTapGesture {
            isSelected.toggle()
            onTapped?()
        }
//        Divider()
    }
}

struct SettingsStandardCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SettingsStandardCellView(titleText: "title", descriptionText: "description", isSelected: true)
            SettingsStandardCellView(titleText: "title", descriptionText: "description", isSelected: false)
            
            SettingsStandardCellView(titleText: "title", descriptionText: nil, isSelected: true)
            SettingsStandardCellView(titleText: "title", descriptionText: nil, isSelected: false)
            
            SettingsStandardCellView(titleText: nil, descriptionText: "description", isSelected: true)
            SettingsStandardCellView(titleText: nil, descriptionText: "description", isSelected: false)
            
            SettingsStandardCellView(titleText: nil, descriptionText: nil, isSelected: true)
            SettingsStandardCellView(titleText: nil, descriptionText: nil, isSelected: false)
        }
    }
}
