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
    @State private var questionNumber = 0
    @State private var questions = [Question]()
    
    @State private var timestable = 2
    @State private var questionCount = 5
    
    @State private var playerAnswer = ""
    
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
                    
                    Button("Play") {
                        startGame()
                    }
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5.0)
                }
            case GameState.Game:
                VStack {
                    Text("Let's Play")
                    
                    Text("Question \(questionNumber + 1)")
                        .font(.headline)
                    
                    Text("\(questions[questionNumber].text)")
                        .font(.largeTitle)
                    
                    TextField("Answer", text: $playerAnswer)
                        .keyboardType(.numberPad)
                    
                    Button("Submit") {
                        checkAnswer()
                    }
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5.0)
                }
                .padding()
            case GameState.GameOver:
                Text("Game Over")
            }
        }
    }
    
    func startGame() {
        generateQuestions()
        questionNumber = 0
        gameState = GameState.Game
    }
    
    func generateQuestions() {
        questions.removeAll() // Reset the questions array
        
        (0..<questionCount).forEach { _ in
            let multiplierA = timestable; // Int.random(in: 2...timestable)
            let multiplierB = Int.random(in: 1...12)
            let answer = multiplierA * multiplierB
            let question = Question(text: "\(multiplierA) x \(multiplierB)", answer: answer)
            
            questions.append(question) // Insert the new question into the array
        }
    }
    
    func checkAnswer() {
        // TODO is answer correct
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionNumber += 1
        playerAnswer = ""
        
        if(questionNumber >= questionCount) {
            gameState = GameState.GameOver
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
