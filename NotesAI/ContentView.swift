//
//  ContentView.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-08.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var auth = AuthService.shared
    @State private var isLoaded = false
    
    var body: some View {
        Group{
            if !isLoaded {
                ProgressView()
                    .onAppear {
                        auth.fetchCurrentAppUser { _ in
                            isLoaded = true
                        }
                    }
            } else if auth.currentUser == nil {
                AuthGate()
            } else {
                ProfileView()
            }
        }
    }
}
 

#Preview {
    ContentView()
}
