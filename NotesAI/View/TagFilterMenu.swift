//
//  TagFilterMenu.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-24.
//

import Foundation
import SwiftUI

struct TagFilterMenu: View {
    @EnvironmentObject var tagManager: TagManager

    @Binding var selectedTag: Tag?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                
                Button(action: {
                    selectedTag = nil
                }) {
                    Text("All")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(
                            selectedTag == nil
                                ? Color.gray.opacity(0.3)
                                : Color.clear
                        )
                        .cornerRadius(8)
                }

                
                ForEach(tagManager.tags) { tag in
                    Button(action: {
                        selectedTag = tag
                    }) {
                        Text(tag.name.count > 10
                             ? String(tag.name.prefix(10)) + "..."
                             : tag.name)
                            .font(.system(size: 14, weight: .medium))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(
                                selectedTag?.id == tag.id
                                    ? tag.color.opacity(0.25)
                                    : Color.clear
                            )
                            .cornerRadius(8)
                            .foregroundColor(tag.color)
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
    }
}

#Preview {
    TagFilterMenu(selectedTag: .constant(nil))
        .environmentObject(TagManager())
    
}



