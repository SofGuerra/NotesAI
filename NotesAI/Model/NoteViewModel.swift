//
//  NoteViewModel.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-11.
//

import Foundation
import FirebaseFirestore
import Combine

class NoteViewModel: ObservableObject {
    
    static let shared = NoteViewModel()

    private let db = Firestore.firestore()
    
    @Published var notes: [Note] = []
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        db.collection("notes").addSnapshotListener { (querySnapshot, error) in
            
            if let error = error {
                print ("\(error.localizedDescription)")
                return
            }
            
            self.notes = querySnapshot?.documents.compactMap({note in
                
                try? note.data(as: Note.self)
            }) ?? []
            self.reorderNotes()
        }
    }
    
    func addNote(title: String, content: String){
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
        reorderNotes()
        do {
            try db.collection("notes").addDocument(from: newNote)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteNote(note: Note) {
        guard let noteID = note.id
        else {
            return
        }
        db.collection("notes").document(noteID).delete{ error in
            if let error = error{
                print (error.localizedDescription)
            }
        }
    }
    
    func editNote(note: Note) {

        guard let noteID = note.id else { return }
        do {
            try
            db.collection("notes").document(noteID).setData(from: note)
        }
        catch {
            print (error.localizedDescription)
        }
           
    }
    
    func pinNote(noteToPin: Note, isPinned: Bool){
        guard let noteID = noteToPin.id else {
            return
        }
        
        if let index = notes.firstIndex(where: { $0.id == noteID}) {
            notes[index].isPinned = isPinned
            reorderNotes()
        }
        
        db.collection("notes").document(noteID).updateData(["isPinned": isPinned])
    }
    
    func reorderNotes(){
        notes.sort {
            if $0.isPinned != $1.isPinned {
                return $0.isPinned && !$1.isPinned
            }
            return $0.dateModified > $1.dateModified
        }
    }
    
    func archiveNotes(archivedNote: Note, isArchived: Bool){
        guard let noteID = archivedNote.id else {
            return
        }
        if let index = notes.firstIndex(where: { $0.id == noteID}){
            notes[index].isArchived = isArchived
            
        }
        db.collection("notes").document(noteID).updateData(["isArchived": isArchived])
    }
}
