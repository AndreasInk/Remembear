//
//  QuestionsView.swift
//  QuestionsView
//
//  Created by Andreas on 7/24/21.
//

import SwiftUI

struct QuestionsView: View {
    

      @State private var showingPaymentDetails = false
    @Binding var i: Int
    @Binding var quiz: Quiz
    @Binding var showCorrect: Bool
      var body: some View {
          VStack {
          ScrollView {
              VStack(alignment: .leading) {
                  ForEach(quiz.questions.indices, id: \.self) { questionIndex in
                      Button(action: {
                          i = questionIndex
                          showCorrect = false
                      }) {
                          HStack {
                          VStack {
                          HStack {
                              Text(quiz.questions[questionIndex].title)
                                  .font(.custom("Montserrat Bold", size: 18)).foregroundColor(Color(.white))
                              .multilineTextAlignment(.leading)
                              .foregroundColor(.white)
                              Spacer()
                             
                      }
                              ScrollView(.horizontal, showsIndicators: false) {
                              HStack {
                              ForEach(quiz.questions[questionIndex].tags, id: \.self) { tag in
                                  Text(tag)
                                      .font(.custom("Montserrat Bold", size: 12)).foregroundColor(Color("Primary"))
                                      .multilineTextAlignment(.leading)
                                      .foregroundColor(Color("Primary"))
                                      .padding(5)
                                      .background(Color(.white))
                                      .cornerRadius(10)
                                  
                              }
                              }
                              }
                          } .padding()
                              Circle()
                                  .frame(width: 25, height: 25)
                                  .foregroundColor(!quiz.questions[questionIndex].selected.isEmpty ? quiz.questions[questionIndex].answer == quiz.questions[questionIndex].selected ? Color(.green).opacity(0.6) : Color(.red).opacity(0.6) : Color("Primary").opacity(0.2))
                          }
                  }
                     
                  }
                Spacer()
              } .padding(.top, 100)
              

          }
              
          } .padding()
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(Color("Secondary"))
              .edgesIgnoringSafeArea(.all)
      }
  }
