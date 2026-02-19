//
//  AIChatViewModel.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class AIChatViewModel {
    private(set) var messages: [Message] = []
    private(set) var isLoading = false
    var inputMessage = ""
    var selectedModel = AIModel.availableModels[0] {
        didSet {
            messages.removeAll()
        }
    }

    @ObservationIgnored private let aiService: any AIServiceProtocol

    init(aiService: any AIServiceProtocol) {
        self.aiService = aiService
    }

    func sendMessage() async {
        guard !inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = Message(content: inputMessage, isUser: true)
        messages.append(userMessage)

        let messageToSend = inputMessage
        inputMessage = ""
        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await aiService.sendChatMessage(messageToSend, model: selectedModel)
            let aiMessage = Message(content: response, isUser: false)
            messages.append(aiMessage)
        } catch is CancellationError {
            return
        } catch let serviceError as AIServiceError {
            let userMessage: String
            switch serviceError {
            case .apiError(let message):
                userMessage = message
            case .invalidURL:
                userMessage = "Error: invalid URL."
            case .invalidResponse:
                userMessage = "Error: invalid response from server."
            case .noData:
                userMessage = "Error: empty response from server."
            case .decodingError:
                userMessage = "Error: response counldn't be decoded."
            }
            let errorMessage = Message(content: userMessage, isUser: false)
            messages.append(errorMessage)
        } catch {
            let errorMessage = Message(content: "Error: \(error.localizedDescription)", isUser: false)
            messages.append(errorMessage)
        }
    }
}
