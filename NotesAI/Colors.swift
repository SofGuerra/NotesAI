//
//  Colors.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-12.
//

import Foundation
import SwiftUI

enum PredefinedColor: String, CaseIterable {
    case redOrange = "#FF5733"
    case blue = "#33C1FF"
    case green = "#28A745"
    case yellow = "#FFC300"
    case violet = "#9B59B6"
    case gray = "#C2C2C2"
    
    var name: String {
        switch self {
        case .redOrange: return "Rojo anaranjado"
        case .blue: return "Azul"
        case .green: return "Verde"
        case .yellow: return "Amarillo"
        case .violet: return "Violeta"
        case .gray: return "Gris"
        }
    }
}


//
//enum predefinedColor: String, CaseIterable {
//    case redOrange
//        case blue
//        case green
//        case yellow
//        case violet
//        case gray
//
//    var color: Color {
//        switch self {
//        case .redOrange:
//            return Color(red: 1.0, green: 0.34, blue: 0.2)    // #FF5733
//        case .blue:
//            return Color(red: 0.2, green: 0.76, blue: 1.0)     // #33C1FF
//        case .green:
//            return Color(red: 0.16, green: 0.65, blue: 0.27)   // #28A745
//        case .yellow:
//            return Color(red: 1.0, green: 0.76, blue: 0.19)    // #FFC300
//        case .violet:
//            return Color(red: 0.61, green: 0.35, blue: 0.71)   // #9B59B6
//        case .gray:
//            return Color(red: 0.76, green: 0.76, blue: 0.76)   // #C2C2C2
//        }
//    }
//    var name: String {
//            switch self {
//            case .redOrange: return "Rojo anaranjado"
//            case .blue: return "Azul"
//            case .green: return "Verde"
//            case .yellow: return "Amarillo"
//            case .violet: return "Violeta"
//            case .gray: return "Gris"
//            }
//        }
//
//}
