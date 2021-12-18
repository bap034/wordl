//
//  WordlApp.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import SwiftUI

@main
struct WordlApp: App {
    var body: some Scene {
        WindowGroup {
            let mainViewModel = MainViewModel()
            MainView(viewModel: mainViewModel)
        }
    }
}
