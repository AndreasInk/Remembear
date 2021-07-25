//
//  QuizView.swift
//  Christmas
//
//  Created by Andreas Ink on 12/19/20.
//

import SwiftUI
struct QuizView: View {
    @State var quiz = Quiz(id: UUID().uuidString, questions: [Question(id: UUID().uuidString, title: "Yes", question: "Question", answers: ["A", "B", "C"], answer: "A", selected: "", reason: "oooooooffffffFFFffFF", noteURL: "", tags: ["Ya"]), Question(id: UUID().uuidString, title: "Hello World", question: "Question2", answers: ["A", "B", "C"], answer: "A", selected: "", reason: "oooooooffffffFFFffFF", noteURL: "", tags: ["Ya"])])
   
    @Binding var i: Int
    @State var done = false
    @State var showCorrect = false
    @State var stopConfetti = false
    @State var showQuestions = false
    @State var gridLayout: [GridItem] = [ ]
    @State private var orientation = UIDeviceOrientation.unknown
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var body: some View {
        let drag = DragGesture()
                   .onEnded {
                       if $0.translation.width < -100 {
                           withAnimation(.easeInOut(duration: 0.5)) {
                               showQuestions = false
                           }
                       }
               }
        ZStack {
            
            Color.clear
            
                .onAppear() {
                    
//                    if UIDevice.current.userInterfaceIdiom == .pad {
//
//                        self.gridLayout = [GridItem(), GridItem(.flexible())]
//                    } else {
//                    self.gridLayout =  [GridItem(.flexible())]
//                    }
                    self.gridLayout =  [GridItem(.flexible())]
                }
                .onRotate { newOrientation in
                            orientation = newOrientation
                   
                }
            
            .onChange(of: showCorrect) { value in
                if !value {
                    stopConfetti = false
                }
            }
            .onChange(of: showCorrect) { value in
                if value {
                if UIDevice.current.userInterfaceIdiom == .phone {
                if !orientation.isFlat {
                self.gridLayout = (orientation.isLandscape) ? [GridItem(), GridItem(.flexible())] :  [GridItem(.flexible())]
                }
                }
                } else {
                    self.gridLayout =  [GridItem(.flexible())]
                }
            }
            
            
              
          
           // LazyVGrid(columns: gridLayout, spacing: 5) {
               
            VStack {
               
                QuizDetails(question: $quiz.questions[i], questions: $quiz.questions, i: $i, done: $done, showCorrect: $showCorrect)
                  
                       
            
          
                if showCorrect {
                    ZStack {
                    CorrectView(question: $quiz.questions[i])
                        VStack {
                            Spacer()
                        Button(action: {
                            if quiz.questions.indices.contains(i + 1) {
                           i += 1
                                showCorrect = false
                            } else {
                                done = true
                            }
                        }) {
                            Text("Next Question")
                                .font(.custom("Montserrat Bold", size: 18))
                                .padding(.horizontal)
                                .foregroundColor(.white)
                        }
                        
                        .buttonStyle(BlueStyle())
                        .padding()
                    }
                    }
                
            }
            
              
            }
            if quiz.questions[i].answer == quiz.questions[i].selected {
                ForEach(0...20, id: \.self) { i in
                  
                    ConfettiView()
                        
                }
            }
//            if done {
//                FinishedQuizView(quiz: $quiz)
//            }
            if showQuestions {
                HStack {
                    QuestionsView(i: $i, quiz: $quiz, showCorrect: $showCorrect)
                    .frame(width: 240)
                    
                 
                    Spacer()
                } .transition(.move(edge: .leading))
                    .zIndex(1)
            }
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showQuestions.toggle()
                        }
                    }) {
                        Image(systemName: "sidebar.squares.left")
                            .padding()
                            .foregroundColor(showQuestions ? Color(.white) : Color("Primary"))
                    }
                    Spacer()
                    
                } .padding()
                Spacer()
            }  .zIndex(1)
            } .gesture(drag)
           
            }
        
        }
    
    


