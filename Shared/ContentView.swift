//
//  ContentView.swift
//  Shared
//
//  Created by Andreas on 7/24/21.
//

import SwiftUI
import PencilKit
struct ContentView: View {
    @State var i = 0
    @State var quizzes = [Quiz]()
    @State var drawing: PKDrawing = PKDrawing()
    var body: some View {
       // NotesView(i: $i, drawing: $drawing)
        //QuizView(i: $i)
       // QuizInputView(quizzes: $quizzes)
        QuizListView(quizzes: $quizzes)
            .onAppear() {
                let url = self.getDocumentsDirectory().appendingPathComponent("quizzes.txt")
                do {
                   
                    let input = try String(contentsOf: url)
                    
                    
                    let jsonData = Data(input.utf8)
                   
                        let decoder = JSONDecoder()
                        
                        
                            let note = try decoder.decode([Quiz].self, from: jsonData)
                            quizzes = note
                  
                                    
                            
                            
                        } catch {
                        }
            }
             .onChange(of: quizzes) { newValue in
                
                let encoder = JSONEncoder()
               
                if let encoded = try? encoder.encode(quizzes) {
                    if let json = String(data: encoded, encoding: .utf8) {
                        
                        do {
                            let url = self.getDocumentsDirectory().appendingPathComponent("quizzes.txt")
                            try json.write(to: url, atomically: false, encoding: String.Encoding.utf8)
                            
                        } catch {
                            print("erorr")
                        }
                    }
                }
              
                    }
        //QuizInputView()
    }
    
        func getDocumentsDirectory() -> URL {
            // find all possible documents directories for this user
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            // just send back the first one, which ought to be the only one
            return paths[0]
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
