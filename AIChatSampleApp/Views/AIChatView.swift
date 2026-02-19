//
//  AIChatView.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import SwiftUI

struct AIChatView: View {
    @State private var viewModel: AIChatViewModel

    init(aiService: any AIServiceProtocol = AIService(apiKey: Config.apiKey)) {
        _viewModel = State(wrappedValue: AIChatViewModel(aiService: aiService))
    }

    var body: some View {
        VStack {
            Form {
                Picker("AI Model", selection: $viewModel.selectedModel) {
                    ForEach(AIModel.availableModels) { model in
                        Text(model.name).tag(model)
                    }
                }
                .pickerStyle(.menu)
            }
            .frame(height: 70)

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageView(message: message)
                                .id(message.id)
                        }

                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .padding()
                                .background(.gray.opacity(0.2), in: .rect(cornerRadius: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                }
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: viewModel.messages) { _, messages in
                    if let lastMessage = messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .top)
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            InputView(viewModel: viewModel)
                .background(.bar)
        }
        .navigationTitle("AI Chat")
    }
}

#Preview {
    NavigationStack {
        AIChatView(aiService: PreviewAIService())
    }
}
#if DEBUG
private struct PreviewAIService: AIServiceProtocol {
    func sendChatMessage(_ message: String, model: AIModel) async throws -> String {
        "Respuesta de prueba para: \(message)"
    }
}
#endif

