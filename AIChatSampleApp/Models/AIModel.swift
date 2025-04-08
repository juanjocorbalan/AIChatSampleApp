//
//  AIModel.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import Foundation

struct AIModel: Identifiable {
    let id: String
    let name: String

    static let availableModels: [AIModel] = [
        AIModel(id: "meta-llama/llama-4-maverick:free", name: "Llama 4 Maverick"),
        AIModel(id: "mistralai/devstral-small:free", name: "Mistral DevStral Small"),
        AIModel(id: "deepseek/deepseek-chat:free", name: "DeepSeek V3"),
    ]
}
