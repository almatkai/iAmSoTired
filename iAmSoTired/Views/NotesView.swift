//
//  NotesView.swift
//  TodoList
//
//  Created by Almat Kairatov on 25.12.2022.
//

import SwiftUI
import RealmSwift

@available(iOS 16.0, *)
struct NotesView: View {
    
    @ObservedRealmObject var task: Note
    @State private var noteText: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter note", text: $task.title, axis: .vertical)
                .textFieldStyle(.plain)
                .font(.system(size: 20))
                .padding()
            TextField("Enter subtask", text: $noteText, axis: .vertical)
                .textFieldStyle(.plain)
                .padding()
            Button(action: {
                let note = SubNote()
                note.text = noteText
                
                if(!noteText.isEmpty){
                    $task.notes.append(note)
                }
                // clear the textbox
                noteText = ""
            }, label: {
                Text("Add")
            }).buttonStyle(.borderedProminent)
                .disabled(noteText.isEmpty)
            
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
                .onDelete(perform: $task.notes.remove)
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

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
