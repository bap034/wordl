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

// MARK: - SettingsCellDataProtocol
protocol SettingsCellDataProtocol {
    var titleText: String? { get set }
    var descriptionText: String? { get set }
    var section: SettingsSection { get }
    var ruleType: Rule.RuleType? { get }
    var ruleValue: String { get }
}
extension SettingsCellDataProtocol {
    var id: String { "\(section)-\(titleText ?? "")" }
}

// MARK: - SettingsCellData
struct SettingsStandardCellData: SettingsCellDataProtocol {    
    var titleText: String?
    var descriptionText: String?
    let section: SettingsSection
    
    var isSelected: Bool
    let ruleType: Rule.RuleType?
    let ruleValue: String
}
struct SettingsDropDownCellData: SettingsCellDataProtocol {
    var titleText: String?
    var descriptionText: String?
    let section: SettingsSection
    
    var dropDownOptions: [String]
    let ruleType: Rule.RuleType?
    var ruleValue: String
}
