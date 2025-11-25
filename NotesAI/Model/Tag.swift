//
//  Tag.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-08.
//

import Foundation
import FirebaseFirestore
import SwiftUI

struct Tag: Identifiable, Codable, Equatable {
    
    @DocumentID var id: String?
    var name: String
    var hexColor: String
   // var customColor: String?  // e.g. "#FF5733"
        
    var color: Color {
            Color.fromHex(hexColor)
        }
    static func == (lhs: Tag, rhs: Tag) -> Bool {
                return lhs.name == rhs.name
            }

}




enum CustomColors: String {
    case customRed
    case customBlue
    case customGray
}



extension Color {
    static let customRed = Color(red: 199, green: 34, blue: 22)
    static let customBlue = Color(red: 22, green: 28, blue: 199)
    static let customGray = Color(red: 147, green: 147, blue: 163)
}
