//
//  Task.swift
//  NotesAI
//
//  Created by Juan Monroy on 5/11/25.
//
import Foundation

enum Recurrence: String, CaseIterable, Codable { case none, daily, weekly, monthly }

struct TaskModel: Identifiable, Codable {
    var id: String?
    var noteDetails: Note
    var deadline: Date
    var recurrence: Recurrence = Recurrence.none
    var isCompleted: Bool = false
}
