//
//  ProfileView.swift
//  NotesAI
//
//  Created by Sofia Guerra on 2025-11-08.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var auth = AuthService.shared
    @State private var newName = ""
    @State private var errorMessage: String?
    
    var body: some View {
        Form {
            Section("Profile") {
                Text("Email: \(auth.currentUser?.email ?? "-")")
                Text("Display Name: \(auth.currentUser?.displayName ?? "-")")
                Text("Active Email: \(auth.currentUser?.isActive == true ? "Yes": "No")")
            }
            
            Section("Update Display Name") {
                TextField("New Display Name", text: $newName)
                
                Button("Save"){
                    guard !newName.trimmingCharacters(in: .whitespaces).isEmpty else {
                        self.errorMessage = "Display Name cannot be empty"
                        return
                    }
                    auth.updateProfile(displayName: newName) {
                        result in
                        switch result {
                        case .success(let success):
                            self.newName = ""
                            self.errorMessage = ""
                        case .failure(let failure):
                            self.errorMessage = failure.localizedDescription
                            
                        }
                    }
                }.disabled(newName.isEmpty)
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            
            Button(role: .destructive) { //.destructive automaticamente setea el color del texto a rojo por su naturaleza (destruye el usuario en la sesion activa)
                let result = auth.signOut()
                if case .failure(let failure) = result {
                    self.errorMessage = failure.localizedDescription
                } else {
                    self.errorMessage = nil
                }
            } label: {
                Text("Sign Out")
            }
        }
        .onAppear {
            auth.fetchCurrentAppUser {_ in}
        }
        
    }
}

#Preview {
    ProfileView()
}
