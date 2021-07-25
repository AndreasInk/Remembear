//
//  FinishedQuizView.swift
//  FinishedQuizView
//
//  Created by Andreas on 7/24/21.
//

import SwiftUI

struct FinishedQuizView: View {
    @Binding var quiz: Quiz
    @State var precentCorrect = 0.0
    
    var body: some View {
        ZStack {
            Color("back")
            VStack {
                Text(String(precentCorrect*100) + "%")
                    .font(.custom("Montserrat Bold", size: 36)).foregroundColor(Color("Primary"))
                    .multilineTextAlignment(.center)
                    .padding()
                Text(precentCorrect > 0.7 ? "Great Job!" : "Keep Practicing, you got this!")
                    .font(.custom("Montserrat Bold", size: 18)).foregroundColor(Color("Primary"))
                    .multilineTextAlignment(.center)
                    .padding()
                
            }
            ForEach(0...20, id: \.self) { i in
              
                ConfettiView()
                    
            }
        } .onAppear() {
            let selected = quiz.questions.map{$0.selected}
            let correct = quiz.questions.map{$0.answer}
            for i in selected.indices {
                if correct[i] == selected[i] {
                    precentCorrect += 1
                }
            }
            precentCorrect = precentCorrect/Double(selected.count)
        }
    }
}
