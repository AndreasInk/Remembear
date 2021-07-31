//
//  QuizInputView.swift
//  QuizInputView
//
//  Created by Andreas on 7/25/21.
//

import Combine
import WebKit
import SwiftUI
import SwiftSoup

import NaturalLanguage

struct QuizInputView: View {
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding var quizzes: [Quiz]
    @State var gettingQuiz = false
    @State var quiz: Quiz = Quiz(id: UUID().uuidString, title: "", questions: [Question]())
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack(alignment: .bottom) {
        
                
            VStack {
                
                TextField("Title", text: $quiz.title)
            TextEditor(text: $text)
                Button(action: {
                   
                    sendText(text: text)
                    gettingQuiz = true
                }) {
                    Text("Process")
                } .buttonStyle(BlueStyle())
            } .padding()
                .onReceive(timer) { value in
                    if gettingQuiz {
                    getQuiz()
                    }
                }
        }
        
    }
    func sendText(text: String) {
        let clean = (text).replacingOccurrences(of: "\n", with: "").encoded ?? ""
        print(clean)
       // for clean in tokenizeText(for: clean) {
        let url2 = URL(string: "https://quizapiv3.herokuapp.com/postText?text=" + clean)
        
                guard let requestUrl = url2 else { fatalError() }
                // Prepare URL Request Object
                var request = URLRequest(url: requestUrl)
                request.httpMethod = "POST"
                do {
        
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data {
                            do {
                                var note = try decoder.decode(QuizResponse.self, from: String(data: data, encoding: .utf8)?.data(using: .utf8) ?? Data())
                               // if note.quiz != "..." {
                                print(note)
                               var questions = [Question]()
//                                for i in note.indices {
//                                   // questions.append(Question(id: UUID().uuidString, title: "", question: note[i].question, answers: [note[i].answer], answer: note[i].answer, selected: "", reason: "", noteURL: "", tags: [String]()))
//                                    print(questions)
//                                }
                                quizzes.append(Quiz(id: UUID().uuidString, title: "", questions: questions))
                             //   }
        
        
        
                            } catch {
                                print(error)
                               // sendPrint(text: error.localizedDescription)
                            }
                        }
                    }.resume()
    }
       // }
    }
    let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    
    func tokenizeText(for text: String) -> [String] {
        tagger.string = text
        var paragraphs = [String]()
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .paragraph, scheme: .tokenType, options: options) { tag, tokenRange, stop in
            let word = (text as NSString).substring(with: tokenRange)
            print(word)
            paragraphs.append(word)
        }
        return paragraphs
    }
    func getQuiz() {
     
        let url2 = URL(string: "https://quizapiv3.herokuapp.com/getQuiz")
        
                guard let requestUrl = url2 else { fatalError() }
                // Prepare URL Request Object
                var request = URLRequest(url: requestUrl)
                request.httpMethod = "GET"
                do {
        
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data {
                            do {
                                
                                var quizText = try decoder.decode(APIResponse.self, from: data)
                               
                                
                               // quizText.quiz = (quizText.quiz.replacingOccurrences(of: "\"[", with: "").replacingOccurrences(of: "]\"", with: "")).replacingOccurrences(of: "'", with: "")
                                
                                quizText.quiz = quizText.quiz.replacingOccurrences(of: "\'", with: "\"", options: .literal)
                               quizText.quiz = quizText.quiz.replacingOccurrences(of: "\"s ", with: "s", options: .literal)
                                
                                quizText.quiz = quizText.quiz.replacingOccurrences(of: "\"t ", with: "t", options: .literal)
                                quizText.quiz = quizText.quiz.replacingOccurrences(of: "\"nt ", with: "nt", options: .literal)
                                quizText.quiz = quizText.quiz.replacingOccurrences(of: "\"ll ", with: "ll", options: .literal)
                                print(quizText.quiz)
                                let quiz = try decoder.decode([QA].self, from: quizText.quiz.data(using: .utf8)!)
                         
                              print(quiz)
//                                print(result)
                              //  print(quizText.quiz.parse(to: [QA].self))
//                                let QAS = quizText.quiz.parse(to: [QA].self)
//                                print(QAS)
                                
                                //if note.quiz != "..." {
                               var questions = [Question]()
                                for i in quiz.indices {
                                    let embedding = NLEmbedding.wordEmbedding(for: .english)
                                   var answers = [quiz[i].answer]
                                    
                                    if let embedding = NLEmbedding.wordEmbedding(for: .english) {
                                        let similarWords = embedding.neighbors(for: quiz[i].answer, maximumCount: 3)

                                        for word in similarWords {
                                            answers.append(word.0)
                                        }
                                    }
                                    let decimalCharacters = CharacterSet.decimalDigits
                                    
                                    let decimalRange = quiz[i].answer.rangeOfCharacter(from: decimalCharacters)

                                    if decimalRange != nil {
                                        answers.append(String(Int.random(in: Int(quiz[i].answer.digits)! - Int.random(in: 10...100)...Int(quiz[i].answer.digits)! + Int.random(in: 10...100))) + quiz[i].answer.nonDigits)
                                    }
                                    questions.append(Question(id: UUID().uuidString, title: quiz[i].question , question: quiz[i].question, answers: answers, answer: quiz[i].answer, selected: "", reason: "", noteURL: "", tags: [String]()))
                                    print(questions)
                                }
//
//                                   // gettingQuiz = false
//
                                self.quiz.questions = questions
                                quizzes.append(self.quiz)
//
        print(quiz)
                                
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                print(error)
                               // sendPrint(text: error.localizedDescription)
                            }
                        }
                    }.resume()
    }
    }
}
  
 
extension String {

    func parse<D>(to type: D.Type) -> D? where D: Decodable {

        let data: Data = self.data(using: .utf8)!

        let decoder = JSONDecoder()

        do {
            let _object = try decoder.decode(type, from: data)
            return _object

        } catch {
            return nil
        }
    }
}
class DictionaryEncoder {

    private let encoder = JSONEncoder()

    var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy {
        set { encoder.dateEncodingStrategy = newValue }
        get { return encoder.dateEncodingStrategy }
    }

    var dataEncodingStrategy: JSONEncoder.DataEncodingStrategy {
        set { encoder.dataEncodingStrategy = newValue }
        get { return encoder.dataEncodingStrategy }
    }

    var nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy {
        set { encoder.nonConformingFloatEncodingStrategy = newValue }
        get { return encoder.nonConformingFloatEncodingStrategy }
    }

    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy {
        set { encoder.keyEncodingStrategy = newValue }
        get { return encoder.keyEncodingStrategy }
    }

    func encode<T>(_ value: T) throws -> [String: Any] where T : Encodable {
        let data = try encoder.encode(value)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    }
}

class DictionaryDecoder {

    private let decoder = JSONDecoder()

    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        set { decoder.dateDecodingStrategy = newValue }
        get { return decoder.dateDecodingStrategy }
    }

    var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy {
        set { decoder.dataDecodingStrategy = newValue }
        get { return decoder.dataDecodingStrategy }
    }

    var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy {
        set { decoder.nonConformingFloatDecodingStrategy = newValue }
        get { return decoder.nonConformingFloatDecodingStrategy }
    }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        set { decoder.keyDecodingStrategy = newValue }
        get { return decoder.keyDecodingStrategy }
    }

    func decode<T>(_ type: T.Type, from dictionary: [String: Any]) throws -> T where T : Decodable {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try decoder.decode(type, from: data)
    }
}

extension String {
    var encoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
extension String {
    var nonDigits: String {
        return components(separatedBy: CharacterSet.letters.inverted)
            .joined()
    }
}

