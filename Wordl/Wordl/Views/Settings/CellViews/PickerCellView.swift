//
//  PickerCellView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import SwiftUI

struct PickerCellView: View {
    
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
                            .foregroundColor(StyleGuide.Color.primary)
                    }
                    if let sureDescription = descriptionText {
                        Text(sureDescription)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(StyleGuide.Color.secondary)
                    }
                }
                
                Spacer()
                
                if let sureSelectedValue = selectedValue {
                    Text(sureSelectedValue)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(StyleGuide.Color.secondary)
                }
                
            }
            .padding([.leading, .trailing])
            .contentShape(Rectangle())
            .onTapGesture {
//                withAnimation {
                    showPicker.toggle()
//                }
            }
            
            if showPicker {
                Picker("Select Value", selection: $selectedValue) {
                    ForEach(pickerOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedValue) { newValue in
//                    withAnimation {
                        onValueChange?(newValue)
//                    }
                }
            }
        }
        .background(StyleGuide.Color.background)
        
    }
}

struct SettingsDropDownCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
//        let selectedValue:Binding<String> = Binding<String>.constant("value")
        VStack {
            PickerCellView(titleText: "title",
                             descriptionText: "description",
                             selectedValue: "value",
                             pickerOptions: ["test1", "test2", "test3"],
                             showPicker: true)
            PickerCellView(titleText: "title",
                             descriptionText: "description",
                             selectedValue: "value",
                             pickerOptions: ["test1", "test2", "test3"],
                             showPicker: false)
        }
    }
}
