//
//  MainViewModel.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import Combine
import Foundation

struct GuessedWordData: Identifiable {
    struct Feedback: Identifiable {
        enum DataType {
            case correct
            case wrongSpot
            case incorrect
        }
        
        let id = UUID()
        let letter: String
        let dataType: DataType
    }
    
    let id = UUID()
    let word: String
    let feedbacks: [Feedback]
}

class MainViewModel: ObservableObject {
    
    @Published public private(set)var guessedWords = [GuessedWordData]()
    @Published public private(set)var answerText = "Tap to see the answer"
    @Published public private(set) var shouldResetTextField = false
    
    var helperText: String { "Guess the \(answer.count)-word" }
    private var answer = MainViewModel.getRandomWord().uppercased()
    
    /// Retrieves a random word from the `words` file.
    /// Source: https://stackoverflow.com/a/31462904
    private static func getRandomWord() -> String {
        var word = "Loading..."
        if let wordsFilePath = Bundle.main.path(forResource: "words", ofType: nil) {
            do {
                let wordsString = try String(contentsOfFile: wordsFilePath)
                let wordLines = wordsString.components(separatedBy: .newlines)
                let randomLine = wordLines[numericCast(arc4random_uniform(numericCast(wordLines.count)))]
                print(randomLine)
                word = randomLine
            } catch { // contentsOfFile throws an error
                print("Error: \(error)")
                word = error.localizedDescription
            }
        }
        return word
    }
    
    private func getFeedbacks(guess: String) -> [GuessedWordData.Feedback] {
        var feedbacks = [GuessedWordData.Feedback]()
        let answerLetters = Array(answer)
        let guessLetters = Array(guess)
        
        guard answerLetters.count == guessLetters.count else { return feedbacks }
        
        guessLetters.enumerated().forEach { (index, letter) in
            let answerLetter = answerLetters[index]
            
            let feedbackType: GuessedWordData.Feedback.DataType
            if answerLetter == letter {
                feedbackType = .correct
            } else if answerLetters.contains(letter) {
                feedbackType = .wrongSpot
            } else {
                feedbackType = .incorrect
            }
            
            let feedback = GuessedWordData.Feedback(letter: String(letter), dataType: feedbackType)
            feedbacks.append(feedback)
        }
        return feedbacks
    }
}

// MARK: - View Triggered Events
extension MainViewModel {
    func onTextFieldDidSubmit(newText: String) {
        guard newText.count == answer.count else {
            print("Guess character count mismatch")
            return
        }
        
        let feedbacks = getFeedbacks(guess: newText)
        let newWordData = GuessedWordData(word: newText, feedbacks: feedbacks)
        guessedWords.append(newWordData)
        shouldResetTextField = true
    }
    func didResetTextField() {
        shouldResetTextField = false
    }
    func onAnswerTextTapped() {
        answerText = answer
    }
    func onNewGameTapped() {
        answer = MainViewModel.getRandomWord().uppercased()
        answerText = "Tap to see the answer"
        guessedWords = []
    }
}
