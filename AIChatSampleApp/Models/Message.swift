//
//  Message.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//


import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date

    init(content: String, isUser: Bool) {
        self.content = content
        self.isUser = isUser
        self.timestamp = Date()
    }
}
