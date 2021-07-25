//
//  QuizDetails.swift
//  Christmas
//
//  Created by Andreas on 12/19/20.
//

import SwiftUI

struct QuizDetails: View {
    @Binding var question: Question
    @Binding var questions: [Question]
    @Binding var i: Int
    @Binding var done: Bool
    @Binding var showCorrect: Bool
    var body: some View {
        ZStack {
     Color("redL")
        .opacity(0.6)
        .edgesIgnoringSafeArea(.all)
            
        VStack {
            Spacer()
            QuizQuestion(question: $question, i: $i)
            Spacer()
            
            ForEach(question.answers, id: \.self) { a in
                QuizBtn(question: $question, questions: $questions, i: $i, done: $done, text: a, showCorrect: $showCorrect)
            }
            Spacer()
        }
            }
        }
    
    }

