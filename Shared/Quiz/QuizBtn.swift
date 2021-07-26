//
//  QuizBtn.swift
//  Christmas
//
//  Created by Andreas Ink on 12/19/20.
//

import SwiftUI

struct QuizBtn: View {
    @Binding var question: Question
    @Binding var questions: [Question]
    @Binding var i: Int
    @Binding var done: Bool
    @State var text = "Lol"
   
    @State var questionL = Question(id: "", title: "", question: "", answers: [String](), answer: "A", selected: "", reason: "", noteURL: "", tags: [String]())
    @Binding var showCorrect: Bool
    var body: some View {
      
        Button(action: {
            question.selected = text
            questionL.selected = text
            print(question.selected)
            if question.selected == question.answer {
               
            }
            showCorrect = true
        }) {
            Text(text)
                //.font(.custom("Montserrat Bold", size: question.selected.isEmpty ? 18 : question.selected == text ? 24 : 18))
                .font(.custom("Montserrat Bold", size: 18))
                .padding(.horizontal)
                .foregroundColor(.white)
        } //.disabled(question.selected != "" ? true : false)
        
        .buttonStyle(BlueStyle())
        
        .padding()
    }
    func saveScore() {
        
    }
    }

