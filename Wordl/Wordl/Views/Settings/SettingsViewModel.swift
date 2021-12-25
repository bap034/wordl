//
//  SettingsViewModel.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import Combine
import Foundation


class SettingsViewModel: ObservableObject {
    
    @Published public private(set)var cellDatas = [SettingsCellDataProtocol]()
    
    private let manager: GameManager
    
    init(manager: GameManager = GameManager.shared) {
        self.manager = manager
        cellDatas = generateSettingsDatas()
    }
    
    private func generateSettingsDatas() -> [SettingsCellDataProtocol] {
        var cellDatas = [SettingsCellDataProtocol]()
        
        // Dictionary Section
        DictionaryType.allCases.forEach { dictionaryType in
            let cellData = SettingsStandardCellData(titleText: dictionaryType.titleText,
                                                    descriptionText: dictionaryType.descriptionText,
                                                    section: .dictionary,
                                                    isSelected: manager.rules.dictionary == dictionaryType,
                                                    ruleType: nil,
                                                    ruleValue: dictionaryType.rawValue)
            cellDatas.append(cellData)
        }
        
        Rule.RuleType.allCases.forEach { ruleType in
            let data: SettingsCellDataProtocol
            switch ruleType {
                case .minLetters:
                    let minLengthRange = 3...manager.rules.maxLetters
                    let minLengthRangeStrings = minLengthRange.map({ String($0) })
                    let ruleValue = String(manager.rules.minLetters)
                    data = SettingsDropDownCellData(titleText: ruleType.titleText,
                                                    descriptionText: ruleType.descriptionText,
                                                    section: .rules,
                                                    dropDownOptions: minLengthRangeStrings,
                                                    ruleType: ruleType,
                                                    ruleValue: ruleValue)
                case .maxLetters:
                    let maxLengthRange = manager.rules.minLetters...12
                    let maxLengthRangeStrings = maxLengthRange.map({ String($0) })
                    let ruleValue = String(manager.rules.maxLetters)
                    data = SettingsDropDownCellData(titleText: ruleType.titleText,
                                                    descriptionText: ruleType.descriptionText,
                                                    section: .rules,
                                                    dropDownOptions: maxLengthRangeStrings,
                                                    ruleType: ruleType,
                                                    ruleValue: ruleValue)
                case .missingLast:
                    let ruleValue = String(manager.rules.missingLast)
                    data = SettingsStandardCellData(titleText: ruleType.titleText,
                                                    descriptionText: ruleType.descriptionText,
                                                    section: .customOptions,
                                                    isSelected: manager.rules.missingLast,
                                                    ruleType: ruleType,
                                                    ruleValue: ruleValue)
            }
            
            cellDatas.append(data)
        }
        
        return cellDatas
    }
    
    func getCellDatas(section: SettingsSection) -> [SettingsCellDataProtocol] {
        let filteredCellDatas = cellDatas.filter({ $0.section == section })
        return filteredCellDatas
    }
    private func getCellData(id: String) -> SettingsCellDataProtocol? {
        let cellData = cellDatas.first(where: { $0.id == id })
        return cellData
    }
    
    private func getRule(ruleType: Rule.RuleType, newValueString: String) -> Rule? {
        let value: Any?
        switch ruleType {
            case .minLetters, .maxLetters:
                value = Int(newValueString)
            case .missingLast:
                value = Bool(newValueString)
        }
        
        guard let sureValue = value else { return nil }
        
        let rule = Rule(type: ruleType, value: sureValue)
        return rule
    }
}

// MARK: - View Action Events
extension SettingsViewModel {
    func onSelected(id: String) {
        guard let cellData = getCellData(id: id) else { return } // Show error text?
            switch cellData.ruleType {
                case .minLetters, .maxLetters:
                    break
                case .missingLast:
                    guard let oldValue = Bool(cellData.ruleValue) else { break }
                    var newValue: Bool = oldValue
                    newValue.toggle()
                    let newValueString = String(newValue)
                    manager.updateRule(ruleType: cellData.ruleType, newValue: newValueString)
                case .none:
                    manager.updateRule(ruleType: cellData.ruleType, newValue: cellData.ruleValue)
            }
        cellDatas = generateSettingsDatas()
    }
    func onValueChanged(newValue: String, id: String) {
        guard let cellData = getCellData(id: id) else { return } // Show error text?
        
        manager.updateRule(ruleType: cellData.ruleType, newValue: newValue)
        cellDatas = generateSettingsDatas()
    }
}
