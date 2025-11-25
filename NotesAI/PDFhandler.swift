//
//  PDFhandler.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-24.
//

import Foundation
import PDFKit
import UIKit

func generatePDF(note: Note) -> URL? {

    let fileName = "\(note.title).pdf"
    let pdfURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

    let format = UIGraphicsPDFRendererFormat()
    let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842) // A4 Portrait

    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

    do {
        try renderer.writePDF(to: pdfURL, withActions: { ctx in
            ctx.beginPage()

            let titleFont = UIFont.boldSystemFont(ofSize: 24)
            let bodyFont = UIFont.systemFont(ofSize: 14)

            
            let title = note.title as NSString
            title.draw(in: CGRect(x: 20, y: 40, width: pageRect.width - 40, height: 80),
                       withAttributes: [.font: titleFont])

            let text = note.content as NSString
            text.draw(in: CGRect(x: 20, y: 140, width: pageRect.width - 40, height: pageRect.height - 160),
                      withAttributes: [.font: bodyFont])
        })

        return pdfURL

    } catch {
        print("❌ Error generating PDF: \(error)")
        return nil
    }
}

func sharePDF(url: URL) {
    let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let controller = windowScene.windows.first?.rootViewController {
        controller.present(activityVC, animated: true)
    }
}


