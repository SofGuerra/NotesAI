//
//  Tag.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-08.
//

import Foundation
import FirebaseFirestore
import SwiftUI

struct Tag: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    var hexColor: String   // e.g. "#FF5733"
        
        var color: Color {
            Color(hexColor)
        }

}
