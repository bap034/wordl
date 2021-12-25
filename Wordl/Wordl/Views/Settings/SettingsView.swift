//
//  SettingsView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(SettingsSection.allCases) { section in
                    Section {
                        let datas = viewModel.getCellDatas(section: section)
                        ForEach(datas.indices) { index in
                            let data = datas[index]
                            
                            if let dropDownData = data as? SettingsDropDownCellData {
                                SettingsDropDownCellView(titleText: dropDownData.titleText,
                                                         descriptionText: dropDownData.descriptionText,
                                                         selectedValue: dropDownData.ruleValue,
                                                         pickerOptions: dropDownData.dropDownOptions,
                                                         showPicker: false) { newValue in
                                    viewModel.onValueChanged(newValue: newValue, id: data.id)
                                }
                                
                            } else if let standardData = data as? SettingsStandardCellData {
                                SettingsStandardCellView(titleText: standardData.titleText, descriptionText: standardData.descriptionText, isSelected: standardData.isSelected) {
                                    viewModel.onSelected(id: data.id)
                                }
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    private func getStandardCell(data: SettingsCellDataProtocol) -> Text {
        Text(data.titleText ?? "test")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
