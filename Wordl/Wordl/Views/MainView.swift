//
//  MainView.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import SwiftUI

struct MainView: View {
    
    @State private var enteredText: String = ""
    @State private var showSettings = false
    @State private var showAlert = false
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Section {
                        Text(viewModel.alertText)
                            .foregroundColor(StyleGuide.Color.accent)
                    }
                    
                    Section {
                        if viewModel.enteredText.isEmpty {
                            Text(viewModel.helperText)
                                .foregroundColor(StyleGuide.Color.secondary)
                        } else {
                            Text(viewModel.enteredText)
                                .foregroundColor(StyleGuide.Color.primary)
                        }
                    }
                    .padding()
                    
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
                
                KeyboardView(keys: viewModel.keyboard) { keyboardKey in
                    viewModel.onKeyTapped(key: keyboardKey)
                }
                .frame(height: 155)
                .padding([.leading, .trailing])
            }
            .safeAreaInset(edge: .top) { // Source: https://www.bigmountainstudio.com/community/public/posts/80041-how-do-i-customize-the-navigationview-in-swiftui
                    HStack() {
                        Text("Wordl")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(StyleGuide.Color.accent)
                        
                        Spacer()
                        
                        Button(action: {
                            showSettings = true
                        }) {
                            NavigationLink(destination: SettingsView(viewModel: SettingsViewModel()), isActive: $showSettings) {
                                Image(systemName: "gearshape").renderingMode(.original)
                            }
                        }
                        
                        Button(action: {
                            showAlert = true
                        }) {
                            Image(systemName: "character.bubble").imageScale(.large)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Answer"),
                                message: Text(viewModel.answerText)
                            )
                        }
                        
                        Button(action: {
                            viewModel.onNewGameTapped()
                        }) {
                            Image(systemName: "repeat.circle").imageScale(.large)
                        }
                    }
                .padding()
                .background(StyleGuide.Color.background)
                .accentColor(StyleGuide.Color.accent)
            }
            .background(StyleGuide.Color.background)
            .navigationBarHidden(true)
        }
    }
}

extension MainView {
    private func getTextColor(letterFeedbackType: WordFeedback.LetterFeedback.DataType) -> Color {
        let color: Color
        switch letterFeedbackType {
            case .correct:
                color = StyleGuide.Color.Feedback.correct
            case .wrongSpot:
                color = StyleGuide.Color.Feedback.wrongSpot
            case .incorrect:
                color = StyleGuide.Color.Feedback.unused
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
