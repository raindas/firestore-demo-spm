//
//  ContentView.swift
//  firestore-demo-spm
//
//  Created by President Raindas on 07/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        List (model.list, id: \.self) { item in
            Text(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
