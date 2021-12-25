//
//  SettingsViewModel.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import Combine
import Foundation


class SettingsViewModel: ObservableObject {
    
    @Published public private(set) var cellDatas = [SettingsCellData]()
    
    private let manager: GameManager
    
    init(manager: GameManager = GameManager.shared) {
        self.manager = manager
        cellDatas = generateSettingsDatas()
    }
    
    private func generateSettingsDatas() -> [SettingsCellData] {
        var cellDatas = [SettingsCellData]()
        
        // Dictionary Section
        DictionaryType.allCases.forEach { dictionaryType in
            let cellData = SettingsCellData(titleText: dictionaryType.titleText,
                                            descriptionText: dictionaryType.descriptionText,
                                            section: .dictionary,
                                            type: .standard,
                                            isSelected: manager.rules.dictionary == dictionaryType,
                                            dropDownOptions: [],
                                            ruleType: nil,
                                            ruleValue: dictionaryType.rawValue)
            cellDatas.append(cellData)
        }
        
        Rule.RuleType.allCases.forEach { ruleType in
            let section: SettingsSection
            let cellType: SettingsCellDataType
            let isSelected: Bool
            let dropDownOptions: [String]
            let ruleValue: String
            switch ruleType {
                case .minLetters:
                    section = .rules
                    cellType = .picker
                    isSelected = false
                    
                    let minLengthRange = 3...manager.rules.maxLetters
                    let minLengthRangeStrings = minLengthRange.map({ String($0) })
                    dropDownOptions = minLengthRangeStrings
                    
                    ruleValue = String(manager.rules.minLetters)
                    
                case .maxLetters:
                    section = .rules
                    cellType = .picker
                    isSelected = false
                    
                    let maxLengthRange = manager.rules.minLetters...12
                    let maxLengthRangeStrings = maxLengthRange.map({ String($0) })
                    dropDownOptions = maxLengthRangeStrings
                    
                    ruleValue = String(manager.rules.maxLetters)
                case .missingLast:
                    section = .custom
                    cellType = .toggle
                    isSelected = manager.rules.missingLast
                    dropDownOptions = []
                    ruleValue = String(manager.rules.missingLast)
            }
            let cellData = SettingsCellData(titleText: ruleType.titleText,
                                            descriptionText: ruleType.descriptionText,
                                            section: section,
                                            type: cellType,
                                            isSelected: isSelected,
                                            dropDownOptions: dropDownOptions,
                                            ruleType: ruleType,
                                            ruleValue: ruleValue)
            
            cellDatas.append(cellData)
        }
        
        return cellDatas
    }
    
    func getCellDatas(section: SettingsSection) -> [SettingsCellData] {
        let filteredCellDatas = cellDatas.filter({ $0.section == section })
        return filteredCellDatas
    }
    private func getCellData(id: UUID) -> SettingsCellData? {
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
    func onSelected(id: UUID) {
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
    func onValueChanged(newValue: String, id: UUID) {
        guard let cellData = getCellData(id: id) else { return } // Show error text?
        
        manager.updateRule(ruleType: cellData.ruleType, newValue: newValue)
        cellDatas = generateSettingsDatas()
    }
}
