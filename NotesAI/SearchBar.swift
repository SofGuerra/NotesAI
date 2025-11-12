//
//  SearchBar.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-11.
//


import SwiftUI

struct SearchBar: View {
    
    @Binding var query: String
    @FocusState var searchFocused: Bool
    @Binding var isSearching: Bool
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                if isSearching{
                    HStack (spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        TextField("Search", text: $query)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .focused($searchFocused)
                        if !query.isEmpty {
                            Button{ query = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                    } .padding(8)
                        .background(RoundedRectangle(cornerRadius: 18)
                            .fill(Color(.secondarySystemBackground))
                        ).transition(
                            .move(edge: .trailing).combined(with: .opacity)
                        )
                    Spacer(minLength: 8)
                    Button {
                        closeBar()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 8)
                        .transition(.move(edge: .trailing))
                }
                else{
                    Button { open() } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity)
                    )
                }
            }
            .animation(.easeInOut, value: isSearching)
            .padding()
        }
        Spacer()
    }
    func collapseSearch(){
        query = ""
        searchFocused = false
    }
    
    private func open() {
        isSearching = true
        searchFocused = true
    }
    private func closeBar() {
        query = ""
        searchFocused = false
        isSearching = false
    }
    
}

#Preview {
    SearchBar(query: .constant(""),
              isSearching: .constant(false))
}
