//
//  QuizData.swift
//  Christmas
//
//  Created by Andreas on 12/19/20.
//

import SwiftUI

struct Quiz: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var questions: [Question]
    
}

struct Question: Identifiable, Codable, Hashable{
    var id: String
    var title: String
    var question: String
    var answers: [String]
    var answer: String
    var selected: String
    var reason: String
    var noteURL: String
    var tags: [String]
}
