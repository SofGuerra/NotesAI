//
//  Note.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-11.
//

import Foundation
import FirebaseFirestore


enum TextFormat: String, CaseIterable, Codable { case bold, italic, underline, strikethrough }

enum TextType: String, CaseIterable, Codable { case title, subtitle, body, caption }
//crear variable en la clase themeyfont var textfor y texttype y las referencio alla


struct Note: Identifiable, Codable{
   
    @DocumentID var id: String?
    var title: String //font is never saved in the firebase
    var content: String
    var tags: [Tag?] = []
    var dateCreated: Date = Date()
    var dateModified: Date = Date()
    var isPinned: Bool = false
    var isArchived: Bool = false
}
