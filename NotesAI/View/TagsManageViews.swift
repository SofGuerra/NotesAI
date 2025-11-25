//
//  TagsManageViews.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-11.
//

import SwiftUI
import Combine
import FirebaseCore

struct TagsManageViews: View {
    
    @State private var query = ""
    @EnvironmentObject private var tagManager: TagManager
    @Environment(\.dismiss) private var dismiss
    @State private var newtagName = ""
    
    var body: some View {
        
        NavigationStack{
            
            VStack{
                HStack{
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .bold()
//                            .font(.title)
//                            .foregroundStyle(.black)
//                    }
                    
                    Spacer()
                    
                    Text("Tags")
                        .font(.title2)
                        .foregroundStyle(.primary)
                        .bold()

                    
                    Spacer()
                    
                    Button{
                        tagManager.addTag(name: "Title", hexColor: "#C2C2C2")
                    }label: {
                        Image(systemName: "plus")
                            .bold()
                            .font(.title)
                            .foregroundStyle(.red)
                    }
                }
                List {
                    ForEach($tagManager.tags) { $tag in
                        HStack{
                            Spacer()
                            TextField("Tag name", text: $tag.name, onCommit: {
                                tagManager.editTag(tag: tag)
                            })
                            Spacer()
                            
                            
                            
                                Menu {
                                    ForEach(PredefinedColor.allCases, id: \.self) { color in
                                        Button {
                                            var updatedTag = tag
                                            updatedTag.hexColor = color.rawValue
                                            tagManager.editTag(tag: updatedTag)
                                        } label: {
                                            HStack {
                                                Circle()
                                                    .fill(Color.fromHex(color.rawValue))
                                                    .frame(width: 20, height: 20)
                                                Text(color.name)
                                            }
                                        }
                                    }
                                } label: {
                                    Image(systemName: "circle")
                                        .foregroundColor(.black)
                                }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(tag.color)
                             
                        )
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                tagManager.deleteTag(tag: tag)
                            } label: {
                                Text("Delete")
                                    .bold()
                                    .font(.title)
                                    
                            }
                            
                            
                        }
                    }
                }
                
            }
            .listStyle(.plain)
            Spacer()
            Divider()
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    TagsManageViews()
        .environmentObject(TagManager())
}
