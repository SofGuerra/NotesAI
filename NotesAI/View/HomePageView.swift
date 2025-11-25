//
//  HomePageView.swift
//  NotesAI
//
//  Created by Jimena Marin on 2025-11-18.
//

import SwiftUI

struct HomePageView: View {
    @State private var showNotes = true
    @EnvironmentObject private var noteManager: NoteViewModel
    @State var SideMenu = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        ZStack{
            VStack {
                HStack{
                    Button(action: {
                        withAnimation{
                            self.SideMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                    }
                    Spacer()
                    
                    Text("Notes")
                        .font(.title)
                    Spacer()
                    
                    NavigationLink(destination: NoteDetailView()){
                        Image(systemName: "plus")
                    }
                    
                }.padding()
                Divider()
                
                Picker("", selection: $showNotes){
                    Text("Notes").tag(true)
                    Text("Archived").tag(false)
                }.pickerStyle(.segmented)
                    .padding()
                if showNotes {
                    NoteView()
                } else {
                    NoteArchiveView()
                }
            }
            
            GeometryReader{ gred in
                
                HStack{ //aqui empiezo el menu
                    VStack(spacing: 15){
                        NavigationLink(destination: ProfileView()){
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                                .padding()
                        }
                        NavigationLink(destination: TaskView().environmentObject(TaskViewModel.shared)){
                            Image(systemName: "checkmark.rectangle.stack")
                            Text("Tasks")
                                .padding()
                        }
                        
                        NavigationLink(destination:
                            TagsManageViews().environmentObject(TagManager.shared )){
                            Image(systemName: "tag")
                            Text("Tags")
                                .padding()
                        }
                        Spacer()
                    }
                    .frame(width:gred.size.width / 1.9)
                    .background(Color(colorScheme == .dark ? .black : .white))
                    .padding(.top, 75)
                    Spacer(minLength: 0)
                }
                .offset(x: self.SideMenu ? 0 : -gred.size.width)
                .background(Color.black.opacity(self.SideMenu ? 0.28 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .padding(.top, 75)

                    )}
            }
    }
}

#Preview {
    HomePageView()
        .environmentObject(NoteViewModel.shared)
    
}
