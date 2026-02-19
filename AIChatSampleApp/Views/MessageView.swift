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
                .background(message.isUser ? .blue : .gray.opacity(0.2), in: .rect(cornerRadius: 16))
                .foregroundStyle(message.isUser ? .white : .primary)
                .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
        }
    }
}
