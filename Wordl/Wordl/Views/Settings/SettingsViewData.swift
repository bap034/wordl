//
//  SettingsViewData.swift
//  Wordl
//
//  Created by Brett Petersen on 12/24/21.
//

import Foundation

enum SettingsSection: String, CaseIterable, Identifiable {
    case dictionary
    case rules
    case customOptions
    
    var id: String { self.rawValue }
}
enum SettingsCellDataType {
    case standard
    case dropdown
}

struct SettingsCellData: Identifiable {
    let titleText: String?
    let descriptionText: String?
    let section: SettingsSection
    let type: SettingsCellDataType
    let isSelected: Bool
    let dropDownOptions: [String]
    let ruleType: Rule.RuleType?
    let ruleValue: String
    
    let id = UUID()
}
