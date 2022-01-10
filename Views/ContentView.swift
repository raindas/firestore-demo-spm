//
//  ContentView.swift
//  firestore-demo-spm
//
//  Created by President Raindas on 07/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var name = ""
    @State var notes = ""
    
    var body: some View {
        VStack {
            List (model.list) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    // Update button
                    Button {
                        model.updateData(todoToUpdate: item)
                    } label: {
                        Image(systemName: "pencil")
                    }.buttonStyle(BorderlessButtonStyle())
                    // Delete button
                    Button {
                        model.deleteData(todoToDelete: item)
                    } label: {
                        Image(systemName: "minus.circle")
                    }.buttonStyle(BorderlessButtonStyle())

                }
            }
            
            Divider()
            
            Group {
                TextField("Name", text: $name)
                TextField("Notes", text: $notes)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            .padding(.vertical, 5.0)
            
            Button {
                // call add data
                model.addData(name: name, notes: notes)
                
                // clear the text fields
                name = ""
                notes = ""
                
            } label: {
                Text("Add Todo Item")
            }

        }
    }
    
    init() {
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
