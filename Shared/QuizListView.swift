//
//  QuizListView.swift
//  QuizListView
//
//  Created by Andreas on 7/25/21.
//

import SwiftUI
import Blobmorphism
struct QuizListView: View {
    @Binding var quizzes: [Quiz]
    @State var isSearching: Bool = false
    @State var search: String = ""
    @State var addQuiz = false
    var body: some View {
        ZStack {
            
        VStack {
            HStack {
                Spacer()
            SearchBlob(isSearching: $isSearching, search: $search)
                
                Button(action: {
                    addQuiz = true
                }) {
                    Image(systemName: "plus")
                }
            } .padding()
        List {
            ForEach($quizzes, id: \.id) { $quiz in
                QuizRowView(quiz: $quiz)
            }
        }
        } .sheet(isPresented: $addQuiz) {
            QuizInputView(quizzes: $quizzes)
        }
        }
    }
}

