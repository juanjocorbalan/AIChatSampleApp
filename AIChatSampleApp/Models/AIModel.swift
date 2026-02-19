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
        AIModel(id: "meta-llama/llama-4-maverick", name: "Llama 4 Maverick"),
        AIModel(id: "nvidia/nemotron-nano-9b-v2:free", name: "Nemotron Nano"),
        AIModel(id: "google/gemma-3-27b-it:free", name: "Gemma 3"),
    ]
}
