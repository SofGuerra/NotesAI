//
//  TagManger.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-12.
//

import Foundation
import FirebaseFirestore
import Combine
import FirebaseCore

class TagManager: ObservableObject{
    
    private let db = Firestore.firestore()
    
    @Published var tags: [Tag] = []
    
    init() {
            fetchTags()
        }
        
        func fetchTags() {
            db.collection("tags").addSnapshotListener { (querySnapshot, error) in
                
                if let error = error {
                    print ("\(error.localizedDescription)")
                    return
                }
                
                self.tags = querySnapshot?.documents.compactMap({note in
                    
                    try? note.data(as: Tag.self)
                }) ?? []
            }
        }
    
    func addTag(name: String, hexColor: String)
        {
            let newTag = Tag(name: name, hexColor: hexColor)
            
            do {
                try db.collection("tags").addDocument(from: newTag)
                print("Tag added")
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func deleteTag(tag: Tag) {
            guard let tagID = tag.id
            else {
                return
            }
            db.collection("tags").document(tagID).delete{ error in
                if let error = error{
                    print (error.localizedDescription)
                }
            }
        }
        
        func editTag(tag: Tag) {

            guard let tagID = tag.id else { return }
            do {
                try
                db.collection("tags").document(tagID).setData(from: tag)
            }
            catch {
                print (error.localizedDescription)
            }
               
        }
    
    
}
