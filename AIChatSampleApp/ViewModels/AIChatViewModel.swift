//
//  AIChatViewModel.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import Foundation

@MainActor
final class AIChatViewModel: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var isLoading = false
    @Published var inputMessage = ""
    @Published var selectedModel = AIModel.availableModels[0] {
        didSet {
            messages.removeAll()
        }
    }

    private let aiService: AIService

    init(aiService: AIService) {
        self.aiService = aiService
    }

    func sendMessage() async {
        guard !inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = Message(content: inputMessage, isUser: true)
        messages.append(userMessage)

        let messageToSend = inputMessage
        inputMessage = ""
        isLoading = true

        do {
            let response = try await aiService.sendChatMessage(messageToSend, model: selectedModel)
            let aiMessage = Message(content: response, isUser: false)
            messages.append(aiMessage)
        } catch {
            let errorMessage = Message(content: "Error: \(error.localizedDescription)", isUser: false)
            messages.append(errorMessage)
        }

        isLoading = false
    }
}
