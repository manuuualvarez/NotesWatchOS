//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Manny Alvarez on 15/06/2022.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Properties
    let note: Note
    let count: Int
    let index: Int
    
    @State private var isCreditPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            //Header:
            HeaderView(title: "")
            //Content:
            Spacer()
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }//:ScrollView
            Spacer()
            //Footer:
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented) {
                        Settings()
                    }
                Spacer()
                Text("\(index + 1)/\(count)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditPresented) {
                        CreditsView()
                    }
            }//:HStack
            .foregroundColor(.secondary)
        }//:VStack
        .padding(3)
    }
}

// MARK: - Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(note: Note(id: UUID(), text: "Try"), count: 5, index: 1)
    }
}
