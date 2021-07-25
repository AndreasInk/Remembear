//
//  ContentView.swift
//  Shared
//
//  Created by Andreas on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    @State var i = 0
    var body: some View {
        QuizView(i: $i)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
