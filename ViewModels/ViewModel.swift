//
//  ViewModel.swift
//  firestore-demo-spm
//
//  Created by President Raindas on 07/01/2022.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [Todo]()
    
    func updateData(todoToUpdate: Todo) {
        // get a reference to the database
        let db = Firestore.firestore()
        
        // set the data to update
        db.collection("todos").document(todoToUpdate.id).setData(["name": "updated todo name", "notes":"some notes"], merge: true) { error in
            // check for errors
            if error == nil {
                //get the new data
                self.getData()
            }
        }
    }
    
    func deleteData(todoToDelete: Todo) {
        // get a reference to the database
        let db = Firestore.firestore()
        
        // specify the document to delete
        db.collection("todos").document(todoToDelete.id).delete { error in
            // check for errors
            if error == nil {
                // no errors
                
                // remove and update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // remove the todo that was just deleted
                    self.list.removeAll { todo in
                        
                        // check for the todo to remove
                        return todo.id == todoToDelete.id
                    }
                }
            } else {
                // handle the error
            }
        }
    }
    
    func addData(name: String, notes: String) {
        // get a reference to the database
        let db = Firestore.firestore()
        
        // add a document to a collection
        db.collection("todos").addDocument(data: ["name": name, "notes": notes]) { error in
            // check for errors
            if error == nil {
                // no errors
                // call get data to retrieve latest data
                self.getData()
            } else {
                // handle the error
            }
        }
    }
    
    func getData() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("todos").getDocuments { snapshot, error in
            // check for errors
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    //Update the list property on the main thread
                    DispatchQueue.main.async {
                        // get all documents and create Todos
                        self.list = snapshot.documents.map { d in
                            return Todo(id: d.documentID, name: d["name"] as? String ?? "", notes: d["notes"] as? String ?? "")
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
        
    }
    
}
