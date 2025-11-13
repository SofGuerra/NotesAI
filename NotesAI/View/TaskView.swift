//
//  TaskView.swift
//  NotesAI
//
//  Created by Juan Monroy on 2025-10-11.
//

import SwiftUI
import FirebaseCore

struct TaskView: View {
    @EnvironmentObject private var taskManager: TaskViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Image(systemName: "line.3.horizontal")
                    Spacer()
                    Text("Tasks")
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: TaskDetailView()){
                        Image(systemName: "plus")
                    }
                }.padding()
                Divider()
                List {
                    ForEach(taskManager.tasks) { task in
                        
                        HStack {
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                VStack(alignment: .leading) {
                                    Text(task.noteDetails.title)
                                    Text("Deadline: \(task.deadline.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.caption)
                                    Text("Recurrence: \(task.recurrence.rawValue.capitalized)")
                                        .font(.caption)
                                }
                            }
                            Spacer()
                            Toggle(isOn: Binding(get: {task.isCompleted},
                                                 set: {newValue in
                                taskManager.toggleTask(task: task, isCompleted: newValue)})){
                                    EmptyView()
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(.plain)
                .onAppear {
                    if !taskManager.tasks.isEmpty {
                        Task {
                            taskManager.fetchTasks()
                        }
                    }
                }
                Spacer()
                Divider()
            }
            .padding(.horizontal)
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = taskManager.tasks[index]
            taskManager.deleteTask(task: task)
        }
    }
}

#Preview {
    TaskView()
        .environmentObject(TaskViewModel.shared)
}
