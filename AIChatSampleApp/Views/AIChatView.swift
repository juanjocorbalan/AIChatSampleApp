//
//  AIChatView.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import SwiftUI

struct AIChatView: View {
    @StateObject private var viewModel: AIChatViewModel

    init() {
        let aiService = AIService(apiKey: Config.apiKey)
        _viewModel = StateObject(wrappedValue: AIChatViewModel(aiService: aiService))
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
                                .background(.gray.opacity(0.2))
                                .cornerRadius(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages) { _, messages in
                    if let lastMessage = messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .top)
                        }
                    }
                }
            }

            InputView(viewModel: viewModel)
        }
        .navigationTitle("AI Chat")
    }
}

#Preview {
    NavigationView {
        AIChatView()
    }
}
