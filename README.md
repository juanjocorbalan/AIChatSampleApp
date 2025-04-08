# AIChatSampleApp

A simple iOS app that demonstrates integration with various AI models through OpenRouter's unified API.

## Features

- Chat with multiple AI models including:
  - Llama
  - Mistral
  - DeepSeek

## Requirements

- iOS 17.0+
- Xcode 16.3+
- Swift 6.0+
- OpenRouter API key

## Setup

1. Clone the repository
2. Open `AIChatSampleApp.xcodeproj` in Xcode
3. Sign up for an OpenRouter account at https://openrouter.ai if you haven't already
4. Generate an API key in your OpenRouter dashboard
5. Open `Config.swift` and replace `YOUR-API-KEY` with your actual OpenRouter API key
6. Build and run the app

## Usage

1. Select your preferred AI model from the dropdown menu at the top
2. Type your message in the text field
3. Tap the send button or press return
4. View the AI's response in the chat
5. Switch models at any time (this will clear the current chat history)
