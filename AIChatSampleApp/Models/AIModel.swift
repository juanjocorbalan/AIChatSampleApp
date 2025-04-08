//
//  AIModel.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import Foundation

struct AIModel: Identifiable, Hashable {
    let id: String
    let name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: AIModel, rhs: AIModel) -> Bool {
        lhs.id == rhs.id
    }

    static let availableModels: [AIModel] = [
        AIModel(id: "meta-llama/llama-4-maverick:free", name: "Llama 4 Maverick"),
        AIModel(id: "mistralai/devstral-small:free", name: "Mistral DevStral Small"),
        AIModel(id: "deepseek/deepseek-chat:free", name: "DeepSeek V3"),
    ]
}
