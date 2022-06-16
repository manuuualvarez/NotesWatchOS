//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Manny Alvarez on 15/06/2022.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
