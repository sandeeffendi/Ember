//
//  User.swift
//  ember
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var createdAt: Date = Date()
}
