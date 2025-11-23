//
//  NoteArchiveView.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-18.
//

import SwiftUI

struct NoteArchiveView: View {
    @StateObject var noteManager = NoteViewModel.shared
    var body: some View {
        List {
            ForEach(noteManager.notes.filter{$0.isArchived}){
                note in
                HStack{
                    NavigationLink(destination: NoteDetailView(note: note)){
                        Text(note.title)
                    }
                    Spacer()
                }.swipeActions(edge: .leading, allowsFullSwipe: false){
                    Button {
                        archiveNote(note)
                    } label: {
                        Image(systemName: "archivebox.fill")
                        note.isArchived ? Text("Archived") : Text("Archive")
                    }
                    .tint(.blue)
                }
            }.onDelete(perform: deleteNote)
            
        }.listStyle(.plain)
            .onAppear{
                if !noteManager.notes.isEmpty{
                    Task{
                        noteManager.fetchNotes()
                    }
                }
            }
    }
    private func deleteNote(at offsets: IndexSet){
        //IndexSet is the data type of the index position in a list
        offsets.forEach {
            index in
            let note = noteManager.notes[index]
            noteManager.deleteNote(note: note)
        }
    }
    
    private func archiveNote(_ note: Note){
        let isArchived = note.isArchived
        noteManager.archiveNotes(archivedNote: note, isArchived: !isArchived)
    }
}

#Preview {
    NoteArchiveView()
        .environmentObject(NoteViewModel.shared)
}
