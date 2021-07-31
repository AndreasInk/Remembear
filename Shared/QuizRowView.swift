//
//  QuizRowView.swift
//  QuizRowView
//
//  Created by Andreas on 7/25/21.
//

import SwiftUI

struct QuizRowView: View {
    @Binding var quiz: Quiz
    @State var openQuiz = false
    @State var showQuiz:Bool = false
    @State var precentCorrect = 0.0
    @State var i = 0
    var body: some View {
        Button(action: {
            showQuiz = true
        }) {
       
    
        HStack {
            Text(quiz.title)
                .font(.custom("Montserrat Bold", size: 18)).foregroundColor(Color("Primary"))
                .multilineTextAlignment(.center)
            Spacer()
            Text(String(precentCorrect) + "%")
                .font(.custom("Montserrat Bold", size: 14)).foregroundColor(Color("Primary"))
                .multilineTextAlignment(.center)
                .onAppear() {
                    let selected = quiz.questions.map{$0.selected}
                    let correct = quiz.questions.map{$0.answer}
                    for i in selected.indices {
                        if correct[i] == selected[i] {
                            precentCorrect += 1
                        }
                    }
                    precentCorrect = precentCorrect/Double(selected.count)
                }
//                .fullScreenCover(isPresented: $openQuiz) {
//                    QuizView(i: $i)
//
        }
        }
        .fullScreenCover(isPresented: $showQuiz) {
            QuizView(quiz: quiz, i: $i, showQuiz: $showQuiz)
        }
    }
}

