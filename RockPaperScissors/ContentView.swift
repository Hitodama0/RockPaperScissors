//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Biagio Ricci on 29/01/23.
//

import SwiftUI


struct moveModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50))
    }
}

extension View {
    func moveStyle() -> some View {
        modifier(moveModifier())
    }
}

struct ContentView: View {
    let moves: [String] = ["✊", "🤚", "✌️"]
    @State private var computerMove = Int.random(in: 0...2)
    @State private var playerMove: String = ""
    @State private var score: Int = 0
    @State private var rounds: Int = 1
    @State private var text = ""
    @State private var resetAlert = false
    
    var body: some View {
        VStack{
            VStack(spacing: 5) {
                Text("Score: \(score)")
                Text("round: \(rounds)/10")
                Text("Computer move: \(moves[computerMove])")
                Text(text)
            }
            .padding()
            HStack{
                Button(action: {
                    playerMove = "✊"
                    round()
                }, label: {
                    Text("✊")
                        .moveStyle()
                })
                
                Button(action: {
                    playerMove = "🤚"
                    round()
                }, label: {
                    Text("🤚")
                        .moveStyle()
                })
                
                Button(action: {
                    playerMove = "✌️"
                    round()
                }, label: {
                    Text("✌️")
                        .moveStyle()
                })
            }
        }
        .alert("Final score", isPresented: $resetAlert) {
            Button("Reset", action: reset)
        } message: {
            Text("Your final score is \(score)!")
        }
    }
    func game() {
        if playerMove == "✊" && moves[computerMove] == "🤚" || playerMove == "🤚" && moves[computerMove] == "✌️" || playerMove == "✌️" && moves[computerMove] == "✊" {
            text = "Wrong"
            score -= 1
        }
        
        else if playerMove == "✊" && moves[computerMove] == "✌️" || playerMove == "🤚" && moves[computerMove] == "✊" || playerMove == "✌️" && moves[computerMove] == "🤚" {
            text = "Correct"
            score += 1
        }
        else {
            text = "draw"
            score += 0
        }
    }
    
    func round() {
        if rounds < 10 {
            game()
            computerMove = Int.random(in: 0...2)
            rounds += 1
        }
        else{
            resetAlert = true
        }
    }
    
    func reset() {
        round()
        playerMove = ""
        text = ""
        score = 0
        rounds = 1
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
