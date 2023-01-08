//
//  TaskCellView.swift
//  TodoList
//
//  Created by Mohammad Azam on 6/18/22.
//

import SwiftUI

@available(iOS 16.0, *)
struct TaskCellView: View {
    
    let task: Note
    @Environment(\.realm) var realm
    @State var offsetY : CGFloat = 0
        
    private func priorityBackground(_ priority: Priority) -> Color {
        switch priority {
            case .low:
                return .gray
            case .medium:
            return .yellow
            case .high:
                return .red
        }
    }
    
    @State var mainTitle = "Main Menu"

    var body: some View {
//        @State var taskPos:
        NavigationLink {
            Text("NotesView")
            NotesView(task: task)
        } label: {
            VStack{
                HStack {
                    Image(systemName: task.isComplete ? "checkmark.square": "square")
                        .foregroundColor(task.isComplete ? .green : .gray)
                        .onTapGesture {
                            let taskToUpdate = realm.object(ofType: Note.self, forPrimaryKey: task._id)
                            try? realm.write {
                                taskToUpdate?.isComplete.toggle()
                            }
                            
                        }
                    Text(task.title)
                        .lineLimit(2)
                    Spacer()
                    Text(task.priority.rawValue)
                        .padding(6)
                        .frame(width: 75)
                        .background(priorityBackground(task.priority))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
                HStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Text(task.date, style: .time)
                            .font(.system(size:12))
                        Text(task.date, style: .date)
                            .font(.system(size:12))
                    }
                }
            }
        }
    }
}

