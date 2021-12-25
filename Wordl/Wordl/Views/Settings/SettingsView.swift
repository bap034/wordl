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
        List {
            ForEach(SettingsSection.allCases) { section in
                Section {
                    let datas = viewModel.getCellDatas(section: section)
                    ForEach(datas) { data in
                        switch data.type {
                            case .standard:
                                SettingsStandardCellView(titleText: data.titleText, descriptionText: data.descriptionText, isSelected: data.isSelected) {
                                    viewModel.onSelected(id: data.id)
                                }
                            case .dropdown:
                                SettingsDropDownCellView(titleText: data.titleText,
                                                         descriptionText: data.descriptionText,
                                                         selectedValue: data.ruleValue,
                                                         pickerOptions: data.dropDownOptions,
                                                         showPicker: false) { newValue in
                                    viewModel.onValueChanged(newValue: newValue, id: data.id)
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
