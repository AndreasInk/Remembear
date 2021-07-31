//
//  APIResponse.swift
//  APIResponse
//
//  Created by Andreas on 7/26/21.
//

import SwiftUI

struct APIResponse: Codable {
    var quiz: String
    
    
}
struct QuizResponse: Decodable {
    enum QA2: String, Decodable {
           case answer, question
       }
    var quiz: [QA2]
    
    
}
struct QA: Codable {
    var answer: String
    var question: String
    
    
}
enum QA2: String, Decodable {
       case answer, question
   }
