import Foundation
import Combine


@MainActor
class ChatRequestManager: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    @Published var responseData: Data?
    @Published var responseError: Error?

    func makeRequest(text: String) async -> Data?{
        let apiKey = KEY_CHAT
        let model = "text-davinci-003"
        let prompt = text
        let temperature = 0.33
        let maxTokens = 150
        let topP = 1
        let frequencyPenalty = 0.0
        let presencePenalty = 0.6
        let stop = [" Human:", " AI:"]

        let requestBody : [String : Any] = [
            "model": model,
            "prompt": prompt,
            "temperature": temperature,
            "max_tokens": maxTokens,
            "top_p": topP,
            "frequency_penalty": frequencyPenalty,
            "presence_penalty": presencePenalty,
            "stop": stop
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/completions")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        do{
            let (data,_) = try await URLSession.shared.data(for: request)
            responseData = data
            return data
        }catch{
            responseError = error
            return nil
        }
        
    }
}

