//
//  SettingsDropDownCellView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import SwiftUI

struct SettingsDropDownCellView: View {
    
    @State var titleText: String?
    @State var descriptionText: String?
    @State var selectedValue: String
    var pickerOptions = [String]()
    @State var showPicker = false
    var onValueChange: ((String)->Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
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
                
                if let sureSelectedValue = selectedValue {
                    Text(sureSelectedValue)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.gray)
                }
                
            }
            .padding([.leading, .trailing])
            
            if showPicker {
                Picker("Select Value", selection: $selectedValue) {
                    ForEach(pickerOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: selectedValue) { newValue in
                    onValueChange?(newValue)
                }
            }
        }
        .onTapGesture {
            showPicker.toggle()
        }
    }
}

struct SettingsDropDownCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
//        let selectedValue:Binding<String> = Binding<String>.constant("value")
        SettingsDropDownCellView(titleText: "title",
                                 descriptionText: "description",
                                 selectedValue: "value",
                                 pickerOptions: ["test1", "test2", "test3"],
                                 showPicker: true)
    }
}
