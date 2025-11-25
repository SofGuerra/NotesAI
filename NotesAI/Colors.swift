//
//  Colors.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-12.
//

import Foundation
import SwiftUI


extension Color {
    static func fromHex(_ hex: String) -> Color {
        var formatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if formatted.hasPrefix("#") {
            formatted.removeFirst()
        }

        // Debe ser 6 caracteres
        guard formatted.count == 6 else {
            return .gray // fallback si algo sale mal
        }

        var rgbValue: UInt64 = 0
        Scanner(string: formatted).scanHexInt64(&rgbValue)

        return Color(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0
        )
    }
}




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

