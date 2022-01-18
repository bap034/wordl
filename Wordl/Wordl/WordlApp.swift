//
//  WordlApp.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import SwiftUI

@main
struct WordlApp: App {
    
    init() {
        UITableViewCell.appearance().backgroundColor = UIColor(StyleGuide.Color.background)
        UITableView.appearance().backgroundColor = UIColor(StyleGuide.Color.background)
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(StyleGuide.Color.background)
        UISegmentedControl.appearance().backgroundColor = UIColor(StyleGuide.Color.background)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(StyleGuide.Color.primary)], for: .normal) 
    }
    
    var body: some Scene {
        WindowGroup {
            let mainViewModel = MainViewModel()
            MainView(viewModel: mainViewModel)
        }
    }
}
