//
//  CreditsView.swift
//  Notes WatchKit Extension
//
//  Created by Manny Alvarez on 15/06/2022.
//

import SwiftUI

struct CreditsView: View {
    // MARK: - Properties

    // MARK: - Body
    var body: some View {
        VStack(spacing: 3) {
            //Profile
            Image("me-mac")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            //Header
            HeaderView(title: "Credits")
            //Content
            Text("Manu Alvarez")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
            
        }//:VStack
    }
}

// MARK: - Preview
struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
