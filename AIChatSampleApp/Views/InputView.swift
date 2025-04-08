//
//  InputView.swift
//  AIChatSampleApp
//
//  Created by Juanjo Corbalan on 8/4/25.
//

import SwiftUI

struct InputView: View {
    @ObservedObject var viewModel: AIChatViewModel

    var body: some View {
        Divider()

        HStack {
            TextField("Message...", text: $viewModel.inputMessage)
                .textFieldStyle(.roundedBorder)
                .disabled(viewModel.isLoading)

            Button(action: {
                Task {
                    await viewModel.sendMessage()
                }
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 24))
                    .symbolEffect(.bounce, value: viewModel.isLoading)
            }
            .disabled(viewModel.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
        }
        .padding()
    }
}
