//
//  NoteView.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-11.
//

import SwiftUI
import FirebaseCore

struct NoteView: View {
    
    @EnvironmentObject private var noteManager: NoteViewModel
    @State private var showNotes = true //para el picker como en el login
    var body: some View {
        NavigationView {
            //top menu
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Image(systemName: "line.3.horizontal")
                    Spacer()
                    Text("Notes")
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: NoteDetailView()){
                        Image(systemName: "plus")
                    }
                    
                }.padding()
                Divider()
                //                VStack {
                //                    Picker("", selection: $showNotes){
                //                        Text("Notes").tag(true) //el tag hace que si seleccionas el "login" se muestra el showlogin como true
                //                        Text("Archived").tag(false)  //el "login" se muestra el showlogin como false
                //                    }.pickerStyle(.segmented) //automatico es con flechitas, .inline es como el timer de iphone
                //                        .padding()
                //                    if showNotes {
                //                        NoteView()
                //                    } else {
                //                        NoteArchiveView()
                //                    }
                //                }
                // filtro de tags
                
                List {
                    ForEach(noteManager.notes){
                        note in
                        HStack{
                            NavigationLink(destination: NoteDetailView(note: note)){
                                Text(note.title)
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
                        }
                    }.onDelete(perform: deleteNote)
                    
                    
                    //SWIPE ACTION PARA PIN
                    //no necesito pasar el parametro de que nota por que ya toma el index del foreach
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
                SearchBar(query: .constant(""),
                          isSearching: .constant(false))
                
            }
            .padding(.horizontal)
            
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
    
    private func pinNote(_ note: Note){
        let isPinned = note.isPinned
        noteManager.pinNote(noteToPin: note, isPinned: !isPinned)
        
    }
}



#Preview {
    NoteView()
        .environmentObject(NoteViewModel.shared)
}
