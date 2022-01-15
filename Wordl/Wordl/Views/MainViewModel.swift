//
//  MainViewModel.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import Combine
import Foundation



class MainViewModel: ObservableObject {

    private static let answerTextConstant = "Tap to see the answer"
    
    @Published public private(set) var guessedWords = [WordFeedback]()
    @Published public private(set) var answerText = MainViewModel.answerTextConstant
    @Published public private(set) var shouldResetTextField = false
    @Published public private(set) var showSettings = false
    
    var helperText: String { "Guess the \(GameManager.shared.gameAnswerCount)-word" }
    private var manager: GameManager
        
    init(manager: GameManager = GameManager.shared) {
        self.manager = manager
    }
    
    private func resetAnswerText() {
        answerText = MainViewModel.answerTextConstant
    }
}

// MARK: - View Triggered Events
extension MainViewModel {
    func onTextFieldDidSubmit(newText: String) {
        let result = manager.guessWord(newText)
        switch result {
            case .success(let wordFeedback):
                guessedWords.insert(wordFeedback, at: 0)
                shouldResetTextField = true
            case .failure(let error):
                print(error)
                // Show error text
        }
        
    }
    func didResetTextField() {
        shouldResetTextField = false
    }
    func onAnswerTextTapped() {
        if answerText == MainViewModel.answerTextConstant {
            answerText = manager.answer
        } else {
            resetAnswerText()
        }
    }
    func onNewGameTapped() {
        manager.newGame()
        resetAnswerText()
        guessedWords = []
    }
}
