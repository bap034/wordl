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
//        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(StyleGuide.Color.background)
        UITableView.appearance().backgroundColor = UIColor(StyleGuide.Color.background)
    }
    
    var body: some Scene {
        WindowGroup {
            let mainViewModel = MainViewModel()
            MainView(viewModel: mainViewModel)
        }
    }
}
