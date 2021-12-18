//
//  MainView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import SwiftUI

struct MainView: View {
    
    @State var enteredText: String = ""
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text(viewModel.answerText)
                        .onTapGesture {
                            viewModel.onAnswerTextTapped()
                        }
                }
                
                Section {
                    TextField(viewModel.helperText,
                              text: $enteredText)
                        .onSubmit {
                            viewModel.onTextFieldDidSubmit(newText: enteredText)
                            if viewModel.shouldResetTextField {
                                enteredText = ""
                                viewModel.didResetTextField()
                            }
                        }
                        .textInputAutocapitalization(.characters)
                        .disableAutocorrection(true)
                }
                
                Section {
                    ForEach(viewModel.guessedWords) { wordData in
                        HStack {
                            ForEach(wordData.feedbacks) { feedback in
                                let color = getTextColor(feedbackType: feedback.dataType)
                                Text(feedback.letter)
                                    .foregroundColor(color)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Wordl")
            .toolbar {
                Button(action: {
                    viewModel.onNewGameTapped()
                }) {
                    Image(systemName: "repeat.circle").imageScale(.large)
                }
            }
        }
    }
}

extension MainView {
    private func getTextColor(feedbackType: GuessedWordData.Feedback.DataType) -> Color {
        let color: Color
        switch feedbackType {
            case .correct:
                color = .teal
            case .wrongSpot:
                color = .orange
            case .incorrect:
                color = .black
        }
        return color
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainViewModel()
        MainView(viewModel: viewModel)
    }
}
