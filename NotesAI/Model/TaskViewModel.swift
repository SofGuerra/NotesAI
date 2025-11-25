//
//  TaskViewModel.swift
//  NotesAI
//
//  Created by Juan Monroy on 8/11/25.
//

import Foundation
import FirebaseFirestore
import Combine

class TaskViewModel: ObservableObject {
    
    static let shared = TaskViewModel()
    private let db = Firestore.firestore()
    @Published var tasks: [TaskModel] = []

    init() {
        fetchTasks()
    }

    func fetchTasks() {
        db.collection("tasks").addSnapshotListener { (querySnapshot, error) in
            
            if let error = error {
                print ("\(error.localizedDescription)")
                return
            }
            
            self.tasks = querySnapshot?.documents.compactMap({task in
                var newTask: TaskModel?
                try? newTask = task.data(as: TaskModel.self)
                newTask?.id = task.documentID
                return newTask
            }) ?? []
            self.reorderTasks()
        }
    }
    
    func addTask(task: TaskModel){
        do {
            try db.collection("tasks").addDocument(from: task)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteTask(task: TaskModel) {
        guard let taskID = task.id
        else {
            return
        }
        db.collection("tasks").document(taskID).delete{ error in
            if let error = error{
                print (error.localizedDescription)
            }
        }
    }

    func editTask(task: TaskModel) {
        var modifiedTask = task
        guard let taskID = task.id else { return }
        do {
            modifiedTask.noteDetails.dateModified = Date.now
            try db.collection("tasks").document(taskID).setData(from: modifiedTask)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toggleTask(task: TaskModel, isCompleted: Bool) {
        print(task)
        guard let taskID = task.id else { return }
        db.collection("tasks").document(taskID).updateData(["isCompleted": isCompleted])
    }
    
    
    func reorderTasks(){
            tasks.sort {
                return $0.noteDetails.dateModified > $1.noteDetails.dateModified
            }
        }
}
