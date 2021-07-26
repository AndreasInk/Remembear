//
//  AddQuizNote.swift
//  AddQuizNote
//
//  Created by Andreas on 7/25/21.
//

import SwiftUI

struct AddQuizNote: View {
    @Binding var text: String
    var body: some View {
        
        TextEditor(text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

