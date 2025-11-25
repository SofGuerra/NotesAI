//
//  NoteDetailView.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-11.
//

import SwiftUI
import FirebaseFirestore
import Combine

struct NoteDetailView: View {
    
    @StateObject var noteManager = NoteViewModel.shared
    @Environment(\.dismiss) var dismiss
    @State var note: Note?
    @State private var isEditing = false
    @State private var newNoteTitle = ""
    @State private var newNoteContent = ""
    @State private var textSelection: TextSelection?
    
    var body: some View {
        
        VStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    if isEditing || note == nil {
                        TextField("Title", text: $newNoteTitle, selection: $textSelection)
                            .font(.title)
                            .textSelection(.enabled)
                            

                        TextEditor(text: $newNoteContent, selection: $textSelection)
                            .frame(minHeight:  100)
                            .writingToolsBehavior(.complete)
                        
                    } else {
                        if let existingNote = note {
                            Text(existingNote.title)
                                .font(.title)
                            Text(existingNote.content)
                        }
                    }
                }.padding(.horizontal)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .contentShape(Rectangle())
            .onTapGesture { if let existingNote = note {
                newNoteTitle = existingNote.title
                newNoteContent = existingNote.content
                isEditing = true
                }
            }
            
            Spacer()
            HStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20){
                        HStack(spacing: 25){
                            Button{
                                
                            }label: {
                                Image(systemName: "bold")
                            }
                            Button{
                                dismiss()
                            }label: {
                                Image(systemName: "italic")
                            }
                            Button{
                                dismiss()
                            }label: {
                                Image(systemName: "underline")
                            }
                            Button{
                                dismiss()
                            }label: {
                                Image(systemName: "strikethrough")
                            }
                        }.padding(10)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                        Spacer()
                        Button{
                            dismiss()
                            
                        }label: {
                            Text("Title")
                                .font(.title)
                        }
                        Button{
                            dismiss()
                        }label: {
                            Text("Subtitle")
                                .font(.title2)
                        }
                        Button{
                            dismiss()
                        }label: {
                            Text("Body")
                                .font(.body)
                        }
                        Button{
                            dismiss()
                        }label: {
                            Text("Caption")
                                .font(.caption)
                        }
                        
                    }
                    .padding()
                    .foregroundColor(.primary)
                }
            }
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                HStack (spacing: 16){
                    
                    Button{
                        dismiss() // share y export
                    }label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    if isEditing || note == nil {
                        Button{
                            if let existingNote = note {
                                var update = existingNote
                                update.title = newNoteTitle
                                update.content = newNoteContent
                                noteManager.editNote(note: update)
                            } else {
                                noteManager.addNote(title: newNoteTitle, content: newNoteContent)
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                    
                }
                .padding()
                .foregroundColor(.primary)
                .animation(.easeInOut, value: isEditing)
                
            }
        }
        
    }
}


#Preview {
    NoteDetailView()
        .environmentObject(NoteViewModel.shared)
}
