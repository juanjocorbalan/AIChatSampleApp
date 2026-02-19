//
//  InputView.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import SwiftUI

struct InputView: View {
    @Bindable var viewModel: AIChatViewModel
    @State private var sendTrigger: UUID?

    var body: some View {
        VStack(spacing: 0) {
            Divider()

            HStack {
                TextField("Message...", text: $viewModel.inputMessage)
                    .textFieldStyle(.roundedBorder)
                    .disabled(viewModel.isLoading)
                    .submitLabel(.send)
                    .onSubmit {
                        sendTrigger = UUID()
                    }

                Button(action: {
                    sendTrigger = UUID()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 24))
                        .symbolEffect(.bounce, value: viewModel.isLoading)
                }
                .disabled(viewModel.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
            }
            .padding()
        }
        .task(id: sendTrigger) {
            guard sendTrigger != nil else { return }
            await viewModel.sendMessage()
        }
    }
}
