//
//  MessageView.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import SwiftUI

struct MessageView: View {
    let message: Message

    var body: some View {
        HStack {
            Text(message.content)
                .padding()
                .background(message.isUser ? Color.blue : .gray.opacity(0.2))
                .foregroundStyle(message.isUser ? Color.white : .primary)
                .cornerRadius(16)
                .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
        }
    }
}
