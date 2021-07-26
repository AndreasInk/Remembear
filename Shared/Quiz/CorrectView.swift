//
//  CorrectView.swift
//  CorrectView
//
//  Created by Andreas on 7/24/21.
//

import SwiftUI

struct CorrectView: View {
    @Binding var question: Question
    @State var edit: Bool = false
    var body: some View {
        
        VStack {
        HStack {
        Text("Correct Response:")
            .font(.custom("Montserrat Bold", size: 14)).foregroundColor(Color("Primary"))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
        Spacer()
        } .padding()
        HStack {
        Text(question.answer)
            .font(.custom("Montserrat Bold", size: 24)).foregroundColor(Color("Primary"))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            Spacer()
        }  .padding()
                Spacer()
        Text(question.reason)
            .font(.custom("Montserrat Bold", size: 18)).foregroundColor(Color("Primary"))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .padding()
        if question.noteURL.isEmpty {
            Button(action: {
           edit = true
            }) {
                HStack {
                    Image(systemName: "plus")
                        .font(.custom("Montserrat Bold", size: 18)).foregroundColor(Color("Primary"))
                    Text("Add Note")
                        .font(.custom("Montserrat Bold", size: 18)).foregroundColor(Color("Primary"))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                } .padding()
            }
                   }
            Spacer(minLength: 100)
        } .padding()
            .sheet(isPresented: $edit) {
                AddQuizNote(text: $question.reason)
            }
    }
}


