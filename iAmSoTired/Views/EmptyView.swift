//
//  EmptyView.swift
//  TodoList
//
//  Created by Almat Kairatov on 27.12.2022.
//

import SwiftUI
import RealmSwift

struct EmptyView: View {
    @State private var noteText: String = ""
    
    @State private var taskName: String = ""
    
    @State var user: User
    
    @ObservedResults(Note.self) var tasks: Results<Note>

    @State private var date = Date.now
    
    var task = Note()
    
    @State private var isAdded = false
    
    @State var text = ""
    
    
    var body: some View {
        VStack {
            HStack{
                TextField("Enter note", text: $text, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.system(size: 20))
                    .padding()
//                    .onChange(of: task.title){ text in
//                        if(!isAdded){
//                            task.owner_id = user.id
//                            $tasks.append(task)
//                            isAdded = true
//                        }
//                    }
            }
            Button(action: {
                task.title = text
                task.owner_id = user.id
                print(task.title)
                $tasks.append(task)
                isAdded = true
            }, label: {
                Text("Save")
            })
            Divider()
            HStack{
                TextField("Enter subtask", text: $noteText, axis: .vertical)
                    .textFieldStyle(.plain)
                Button(action: {
                    let note = SubNote()
                    note.text = noteText
                    if(!noteText.isEmpty){
                        task.notes.append(note)
                    }
                    // clear the textbox
                    noteText = ""
                }, label: {
                    Text("Add")
                }).buttonStyle(.borderedProminent)
                    .disabled(noteText.isEmpty)
            }
//            ToFormsView()
            Spacer()
            
            List {
                ForEach(task.notes.indices, id: \.self) { index in
                    let note = task.notes[index]
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 25, height: 25)
                            .background(.orange)
                            .foregroundColor(.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                        Text(note.text)
                    }
                }
                .onDelete(perform: task.notes.remove)
                .listStyle(.plain)
            }.listStyle(.plain)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
////                    TextField("Navigation Title", text: $task.title)
////                        .font(.system(size:24))
////                        .fontWeight(.bold)
//                    Text("")
//                }
//            }
        }.padding()
    }
}
