//
//  ContentView.swift
//  Edutainment
//
//  Created by Sean Dooley on 11/11/2024.
//

import SwiftUI

struct ContentView: View {
    enum GameState {
        case Menu
        case Game
        case GameOver
    }
    
    let questionCountOptions = [5,10,20]
    
    @State private var gameState: GameState = GameState.Menu
    @State private var isGameActive = false
    @State private var currentQuestionIndex = 0
    @State private var questions = [Question]()
    
    @State private var timestable = 2
    @State private var questionCount = 5
    
    var body: some View
    {
        NavigationStack
        {
            switch(gameState) {
            case GameState.Menu:
                Form
                {
                    Section("Timestable")
                    {
                        Picker("", selection: $timestable)
                        {
                            ForEach(2..<13)
                            {
                                Text("\($0)")
                            }
                        }
                    }
                    
                    Section("Number of questions")
                    {
                        Picker("", selection: $questionCount)
                        {
                            ForEach(questionCountOptions, id: \.self)
                            {
                                Text("\($0)")
                            }
                        }
                    }
                    
                    Button("Play")
                    {
                        startGame()
                    }
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5.0)
                }
            case GameState.Game:
                Text("Let's Play")
            case GameState.GameOver:
                Text("Game Over")
            }
        }
    }
    
    func startGame()
    {
        generateQuestions()
        gameState = GameState.Game
    }
    
    func generateQuestions() {
        questions.removeAll() // Reset the questions array
        
        (0..<questionCount).forEach { _ in
            let multiplierA = Int.random(in: 2...timestable)
            let multiplierB = Int.random(in: 1...12)
            let answer = multiplierA * multiplierB
            let question = Question(text: "\(multiplierA) x \(multiplierB)", answer: answer)
            
            questions.append(question) // Insert the new question into the array
        }
    }
}

#Preview {
    ContentView()
}

struct Question {
    let text: String
    let answer: Int
}
