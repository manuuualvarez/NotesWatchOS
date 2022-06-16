//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Manny Alvarez on 15/06/2022.
//

import SwiftUI

struct ContentView: View {
    //    MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    //    MARK: - Funtions
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func saveNote() {
//        dump(notes)
        do {
            let data = try  JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving data failed!")
        }
    }
    
    func loadNotes() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                
            }
        }
    }
    
    func deleteNote(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            saveNote()
        }
    }
    //    MARK: - Body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add new note", text: $text)
                
                Button(action: {
                    //1. Only run the buttons action when the text is not empty
                    guard text.isEmpty == false else { return }
                    //2. Create a new Note Item
                    let note = Note(id: UUID(), text: text)
                    //3. Add the note to the array
                    notes.append(note)
                    //4. Make the text empty
                    text = ""
                    //5. Save the note
                    saveNote()
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                })
                .fixedSize()
//                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                //:Button
            }//:HStack
            Spacer()
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self) { note in
                        NavigationLink(destination: DetailView(note: notes[note], count: notes.count, index: note)) {
                            HStack{
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[note].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                                
                            }//:HStak
                        }//:NavigationLink
                    }//:Loop
                    .onDelete(perform: deleteNote)
                }//:List
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }//:Conditional
        }//:VStack
        .navigationTitle("Notes")
        .onAppear(perform: loadNotes)
    }
}

//    MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
