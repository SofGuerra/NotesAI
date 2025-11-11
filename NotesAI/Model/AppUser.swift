//
//  AppUser.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-08.
//

import Foundation
import FirebaseFirestore

struct AppUser: Identifiable, Codable {
    
    @DocumentID var id: String?
    let email: String
    var displayName: String
    var isActive: Bool = true
    
}
