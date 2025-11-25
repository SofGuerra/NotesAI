//
//  NoteView.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-11.
//

import SwiftUI
import FirebaseCore

struct NoteView: View {
    @State private var query = ""
    @State private var isSearching = false
    @StateObject var noteManager = NoteViewModel.shared
    var body: some View {
            //top menu
            VStack(alignment: .leading, spacing: 10){
                
                List {
                    ForEach(noteManager.notes.filter{!$0.isArchived}){
                        note in
                        HStack{
                            NavigationLink(destination: NoteDetailView(note: note)
                                .environmentObject(TaskViewModel.shared)){
                                VStack (alignment: .leading){
                                    Text(note.title)
                                    Text(note.content)
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                        }.swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button {
                                pinNote(note)
                            } label: {
                                Image(systemName: "pin.fill")
                                note.isPinned ? Text("Unpin") : Text("Pin")
                            }
                            .tint(.yellow)
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
                Spacer()
                Divider()
                SearchBar(query: $query, isSearching: $isSearching)
                
            }
            .padding(.horizontal)
        
    }
    
    private func deleteNote(at offsets: IndexSet){
        //IndexSet is the data type of the index position in a list
        offsets.forEach {
            index in
            let note = noteManager.notes[index]
            noteManager.deleteNote(note: note)
        }
    }
    
    private func pinNote(_ note: Note){
        let isPinned = note.isPinned
        noteManager.pinNote(noteToPin: note, isPinned: !isPinned)
    }
    
    private func archiveNote(_ note: Note){
        let isArchived = note.isArchived
        noteManager.archiveNotes(archivedNote: note, isArchived: !isArchived)
    }
}



#Preview {
    NoteView()
        .environmentObject(NoteViewModel.shared)
}
