//
//  TodoListView.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI
import RealmSwift

enum Sections: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct TodoListView: View, Animatable {
    
    @State private var hasTimeElapsed = false
    
    @Environment(\.realm) private var realm
    
    @ObservedResults(Note.self) var tasks: Results<Note>
    
    var pendingTasks: [Note] {
        tasks.filter { $0.isComplete == false }
    }
    
    var completedTasks: [Note] {
        tasks.filter { $0.isComplete == true }
    }
    
    var body: some View {
        
        List {
            ForEach(Sections.allCases, id: \.self) { section in
                Section {
                    
                    let filteredTasks = section == .pending ? pendingTasks: completedTasks
                    
                    if filteredTasks.isEmpty {
                        Text("No tasks.")
                    }
 
                    ForEach(filteredTasks, id: \._id) { task in
                        TaskCellView(task: task)
                       
                    }.onDelete { indexSet in
                        
                        indexSet.forEach { index in
                            let task = filteredTasks[index]
                            
                            guard let taskToDelete = realm.object(ofType: Note.self, forPrimaryKey: task._id) else {
                                return
                            }
                            
                            // delete all notes of a selected task
                            for note in taskToDelete.notes {
                                try? realm.write {
                                    realm.delete(note)
                                }
                            }
                            
                            $tasks.remove(taskToDelete)
                            
                        }
                        
                    }
                } header: {
                    Text(section.rawValue)
                        .foregroundColor(section.rawValue == "Completed" ? .green : .gray)
                }

            }
        }
        .listStyle(.plain)
            .frame(alignment: .center)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            hasTimeElapsed = true
                        }
                if(hasTimeElapsed){
                    for task in tasks {
                        if(task.title == ""){
                            $tasks.remove(task)
                        }
                    }
                }
            }
            .transition(.slide)
            .animation(.easeOut(duration: 0.45))
    }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
