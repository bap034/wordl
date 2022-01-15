//
//  MainView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import SwiftUI

struct MainView: View {
    
    @State var enteredText: String = ""
    @State var showSettings = false
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            VStack {
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
                                withAnimation {
                                    viewModel.onTextFieldDidSubmit(newText: enteredText)
                                    if viewModel.shouldResetTextField {
                                        enteredText = ""
                                        viewModel.didResetTextField()
                                    }
                                }
                            }
                            .textInputAutocapitalization(.characters)
                            .disableAutocorrection(true)
                    }
                    
                    Section {
                        ForEach(viewModel.guessedWords) { wordFeedback in
                            HStack {
                                ForEach(wordFeedback.letterFeedbacks) { letterFeedback in
                                    let color = getTextColor(letterFeedbackType: letterFeedback.dataType)
                                    Text(letterFeedback.letter)
                                        .foregroundColor(color)
                                }
                            }
                        }
                    }
                }
                .navigationTitle(
                    Text("Wordl")
                        .foregroundColor(StyleGuide.Color.primary)
                )
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.onNewGameTapped()
                        }) {
                            Image(systemName: "repeat.circle").imageScale(.large)
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            showSettings = true
                        }) {
                            NavigationLink(destination: SettingsView(viewModel: SettingsViewModel()), isActive: $showSettings) {
                                Image(systemName: "gearshape").renderingMode(.original)
                            }
                        }
                    }
                }
                
                KeyboardView { keyboardKey in
                    print("\(keyboardKey.value) tapped")
                }
                .frame(height: 155)
            }
            .background(StyleGuide.Color.background)
            .accentColor(StyleGuide.Color.accent)
        }
    }
}

extension MainView {
    private func getTextColor(letterFeedbackType: WordFeedback.LetterFeedback.DataType) -> Color {
        let color: Color
        switch letterFeedbackType {
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
