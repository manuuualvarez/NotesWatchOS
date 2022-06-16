//
//  Settings.swift
//  Notes WatchKit Extension
//
//  Created by Manny Alvarez on 15/06/2022.
//

import SwiftUI

struct Settings: View {
    // MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    //    MARK: - Functions
    func update() {
        lineCount = Int(value)
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 8) {
            //Header
            HeaderView(title: "Settings")
            //Current Number of lines
            Text("Lines: \(lineCount)")
                .fontWeight(.bold)
            //Slider
            Slider(value: Binding(get: {
                self.value
            }, set: { (newValue) in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
            
        }//VStack
    }
}

// MARK: - Preview
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
