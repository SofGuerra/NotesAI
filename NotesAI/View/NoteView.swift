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
    @EnvironmentObject private var noteManager: NoteViewModel
    @State private var showNotes = true //para el picker como en el login
    
    @StateObject private var tagManager: TagManager = TagManager()
    @State private var selectedTag: Tag?
    
    private var filteredNotes: [Note] {
        
        
        if let tag = selectedTag {
            return noteManager.notes.filter{ note in
                note.tags.contains(tag.id ?? "")
            }
        } else {
            return noteManager.notes
        }
    }
    
    var body: some View {
            //top menu
            VStack(alignment: .leading, spacing: 10){
                
               // TagFilterMenu(selectedTag: $selectedTag) .environmentObject(tagManager)
               TagFilterMenu(selectedTag: $selectedTag)
                   .environmentObject(tagManager)
                   .onChange(of: selectedTag) { newTag in
                       // This code runs whenever the selection changes
                       if let tag = newTag {
                           print("Selected tag: \(tag.name)")
                       } else {
                           print("All tags selected")
                       }
                   }

                
                
                List {
                    ForEach(filteredNotes.filter{!$0.isArchived}){
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
                            Menu {
                                ForEach(tagManager.tags, id: \.id) { tag in
                                    Button {
                                        var updatedNote = note
                                        var tagId = tag.id ?? ""
                                        if !updatedNote.tags.contains(tagId) {
                                            updatedNote.tags.append(tagId)
                                        }
                                        //noteManager.notes[index] = updatedNote
                                        noteManager.editNote(note: updatedNote)
//                                        tagManager.editTag(tag: updatedTag)
                                    } label: {
                                        HStack {
                                    
                                            Text(tag.name)
                                       }
                                   }
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                                    .rotationEffect(.degrees(90))

                            }
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
