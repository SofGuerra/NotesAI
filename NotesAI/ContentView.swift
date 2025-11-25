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
    @StateObject private var taskManager = NoteViewModel.shared
    @State private var themeMode = ColorScheme.light
    var body: some View {
        NavigationView{
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
                    HomePageView()
                        .environmentObject(taskManager)
                }
            }
        }
    }
}
 

#Preview {
    ContentView()
}
