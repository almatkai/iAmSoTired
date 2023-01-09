//
//  HomeView.swift
//  iAmSoTired
//
//  Created by Almat Kairatov on 04.01.2023.
//

import SwiftUI
import RealmSwift

@available(iOS 16.0, *)
struct HomeView: View {
    
    var leadingBarButton: AnyView?
    
    @Environment(\.scenePhase) var appState
    
    @ObservedResults(Note.self) var tasks: Results<Note>
    
    @State var user: User
    
    var body: some View {
        NavigationView {
            
            VStack {
                TodoListView()
                    .clipped()
                    .animation(.easeOut)
                    .transition(.slide)
                Spacer()
                ZStack{
                    HStack{
                        Spacer()
                        NavigationLink{
                            EmptyView(user: user, tasks: $tasks)
                        }label:{
                            Image("addNew")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                        }
                    }
                }.padding()
            
            }.padding()
                .navigationBarItems(leading: self.leadingBarButton)
        }
        
     }
}
