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
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showScore = false
    @State private var showGameOver = false
    
    var body: some View
    {
        VStack
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
                    Text("Score: \(score)")
                    
                    Spacer()
                    
                    Text("Question \(questionNumber + 1)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(questions[questionNumber].text)")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    TextField("Answer", text: $playerAnswer)
                        .keyboardType(.numberPad)
                    
                    Spacer()
                    
                    Button("Submit") {
                        checkAnswer()
                    }
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5.0)
                    
                    Spacer()
                }
                .padding()
                //.opacity(showScore ? 0 : 1)
                //.animation(.default, value: showScore)
                
            case GameState.GameOver:
                VStack {
                    Text("Game Over")
                    Text("Score: \(score)")
                    Button("Play again?") {
                        restartGame()
                    }
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5.0)
                }
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: nextQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game Over", isPresented: $showGameOver) {
            Button("Play again?", action: restartGame)
        } message: {
            Text("You have scored \(score) out of \(questionCount)")
        }
    }
    
    
    func resetGame() {
        questionNumber = 0
        playerAnswer = ""
        score = 0
    }
    
    func startGame() {
        resetGame()
        generateQuestions()
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
        let answer = Int(playerAnswer) ?? 0
        let questionAnswer = questions[questionNumber].answer
        
        if(answer == questionAnswer) {
            score += 1
            scoreTitle = "Well Done!"
            scoreMessage = "You answered correctly with \(answer)"
        }
        else {
            scoreTitle = "Almost!"
            scoreMessage = "The correct answer is \(questionAnswer)"
        }
        
        //questionNumber += 1
        
        if(questionNumber + 1 < questionCount) {
            showScore = true
        }
        else {
            showGameOver = true
        }
    }
    
    func nextQuestion() {
        questionNumber += 1
        playerAnswer = ""
    }
    
    func restartGame() {
        resetGame()
        gameState = GameState.Menu
    }
}

#Preview {
    ContentView()
}

struct Question {
    let text: String
    let answer: Int
}
