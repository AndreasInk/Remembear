//
//  NotesView.swift
//  NotesView
//
//  Created by Andreas on 7/25/21.
//

import SwiftUI
import PencilKit
import Vision

struct NotesView: View {
    //@Binding var note: Note
    @Binding var i: Int
    @State  var canvasView = PKCanvasView()
    @Binding  var drawing: PKDrawing
    @State var color = UIColor.black
    @State var size = 2.0
    @State var editSizes = [false, false, false]
    @State var eraser = false
    
    var body: some View {
        ZStack {
        Color.clear
            .onAppear() {
                do {
            
                    //drawing = try PKDrawing(data: note.canvas)
                    canvasView.drawing = drawing
                } catch {
                    
                }
            }
            .onChange(of: drawing, perform: { value in
                canvasView.drawing = value
                saveDrawing()
            })
            VStack {
                //HeaderView(color: $color, size: $size, editSizes: $editSizes, eraser: $eraser, i: $i)
        CanvasView(canvasView: $canvasView, onSaved: saveDrawing)
            .onChange(of: color, perform: { value in
                canvasView.tool = PKInkingTool(.pen, color: color, width: CGFloat(size))
            })
            .onChange(of: size, perform: { value in
                canvasView.tool = PKInkingTool(.pen, color: color, width: CGFloat(size))
            })
            .onChange(of: eraser, perform: { value in
                if eraser {
                    canvasView.tool =  PKEraserTool(.bitmap)
                } else {
                    canvasView.tool = PKInkingTool(.pen, color: color, width: CGFloat(size))
                }
            })
            .onTapGesture {
                for i in editSizes.indices {
                    withAnimation(.easeInOut) {
                    editSizes[i] = false
                    }
                }
            }
            }
    }
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

private extension NotesView {
  func saveDrawing() {
    print(1)
//              let url = self.getDocumentsDirectory().appendingPathComponent("\(UUID()).data")
//
//              do {
//                  try canvasView.drawing.dataRepresentation().write(to: url)
//                  let input = try String(contentsOf: url)
//                  print(input)
//              } catch {
//                  print(error.localizedDescription)
//              }
      #warning("uncomment later")
    //note.canvas = canvasView.drawing.dataRepresentation()
//    if !drawing.dataRepresentation().isEmpty {
//    let image = canvasView.drawing.image(
//      from: canvasView.bounds, scale: UIScreen.main.scale)
//
//    guard let cgImage = image.cgImage else { return }
//
//    let request = VNRecognizeTextRequest { request, error in
//        guard let observations = request.results as? [VNRecognizedTextObservation] else {
//            fatalError("Received invalid observations")
//        }
//
//        for observation in observations {
//            guard let bestCandidate = observation.topCandidates(1).first else {
//                print("No candidate")
//                continue
//            }
//
//            print("Found this candidate: \(bestCandidate.string)")
//
//
//    }
//    }
//        request.customWords = ["war", "Snorlax", "Charizard"]
//        request.recognitionLevel = .accurate
//    let requests = [request]
//
//    DispatchQueue.global(qos: .userInitiated).async {
//
//        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//        try? handler.perform(requests)
//    }
   
    // }
  }

  func deleteDrawing() {
    canvasView.drawing = PKDrawing()
  }

  func restoreDrawing() {
   
  }

  func shareDrawing() {
    
  }

  func masterpieceSelected(at index: Int) {
   
  }

  func handlePreview() {
   
  }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
