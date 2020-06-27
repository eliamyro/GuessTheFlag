//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Elias Myronidis on 26/6/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var showingScore: Bool = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap on the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                VStack {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number]).renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                }
                
                Text("\(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(self.scoreTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")) {
                self.askQuestion()
                })
        }
    }
    
    // MARK: - Helpers
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            alertMessage = "Score \(score)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Thats the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

// MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
