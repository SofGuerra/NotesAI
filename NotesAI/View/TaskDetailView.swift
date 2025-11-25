//
//  TaskDetailView.swift
//  NotesAI
//
//  Created by Juan Monroy on 2025-10-11.
//

import SwiftUI
import FirebaseFirestore

struct TaskDetailView: View {
    @EnvironmentObject private var taskManager: TaskViewModel
    @State var task: TaskModel?
    @State private var isEditing = false
    @State private var newId = ""
    @State private var newTitle = ""
    @State private var newContent = ""
    @State private var newDeadline = Date()
    @State private var newRecurrence: Recurrence = .none
    @State private var newIsCompleted = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    if isEditing || task == nil {
                        TextField("Title", text: $newTitle)
                            .font(.title)
                        TextEditor(text: $newContent)
                            .frame(minHeight: 100)
                        DatePicker("Deadline", selection: $newDeadline, displayedComponents: [.date, .hourAndMinute])
                        Picker("Recurrence", selection: $newRecurrence) {
                            ForEach(Recurrence.allCases, id: \.self) { recurrence in
                                Text(recurrence.rawValue.capitalized)
                            }
                        }
                        
                    } else {
                        if let existingTask = task {
                            Text(existingTask.noteDetails.title)
                                .font(.title)
                            Text(existingTask.noteDetails.content)
                            Text("Deadline: \(existingTask.deadline.formatted(date: .abbreviated, time: .shortened))")
                            Text("Recurrence: \(existingTask.recurrence.rawValue.capitalized)")
                            Text(existingTask.isCompleted ? "Completed" : "Pending")
                        }
                    }
                }.padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .contentShape(Rectangle())
            .onTapGesture {
                if let existingTask = task {
                    newId = existingTask.id!
                    newTitle = existingTask.noteDetails.title
                    newContent = existingTask.noteDetails.content
                    newDeadline = existingTask.deadline
                    newRecurrence = existingTask.recurrence
                    newIsCompleted = existingTask.isCompleted
                    isEditing = true
                }
            }
            Spacer()
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    if isEditing || task == nil {
                        Button {
                            if let existingTask = task {
                                var update = existingTask
                                update.id = newId
                                update.noteDetails.title = newTitle
                                update.noteDetails.content = newContent
                                update.deadline = newDeadline
                                update.recurrence = newRecurrence
                                update.isCompleted = newIsCompleted
                                taskManager.editTask(task: update)
                            } else {
                                let note = Note(title: newTitle, content: newContent)
                                let newTask = TaskModel(noteDetails: note, deadline: newDeadline, recurrence: newRecurrence, isCompleted: newIsCompleted)
                                taskManager.addTask(task: newTask)
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                .padding()
                .foregroundColor(.black)
                .animation(.easeInOut, value: isEditing)
            }
        }
    }
}

#Preview {
    TaskDetailView()
        .environmentObject(TaskViewModel.shared)
}
