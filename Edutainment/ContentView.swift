//
//  ContentView.swift
//  Edutainment
//
//  Created by Sean Dooley on 11/11/2024.
//

import SwiftUI

struct ContentView: View {
    let questionAmountOptions = [5,10,20]
    
    @State private var isGameActive = false
    @State private var currentQuestionIndex = 0
    
    @State private var selectedTimestable = 2
    @State private var selectedQuestionAmount = 5
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Timestable") {
                    Picker("", selection: $selectedTimestable) {
                        ForEach(2..<13) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("Number of questions") {
                    Picker("", selection: $selectedQuestionAmount) {
                        ForEach(questionAmountOptions, id: \.self)
                        {
                            Text("\($0)")
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
