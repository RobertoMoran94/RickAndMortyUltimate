//
//  ServiceCallBacks.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 1/1/25.
//

import Foundation

class ServiceCallBacks {
    var dataTask: URLSessionDataTask?

    func startNetworkRequest() {
        let url = URL(string: "https://example.com")!
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle response or error
        }
        dataTask?.resume()
    }

    func cancelNetworkRequest() {
        dataTask?.cancel()
    }
}

protocol CallbackService {
    func fetchData<T: Decodable>(url: URL?, completion: @escaping (Result<T, ServiceError>) -> Void)
}

class CallbackServiceImpl: CallbackService {
    func fetchData<T: Decodable>(url: URL?, completion: @escaping (Result<T, ServiceError>) -> Void) {
        guard let url = url else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(self.handleAnyError(with: error)))
                return
            }
            
            do {
                if let data = data {
                    let responseData = try self.handleHTTPResponse(data: data, response: response)
                    let decodedData = try JSONDecoder().decode(T.self, from: responseData)
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.emptyResponse))
                }
            } catch {
                completion(.failure(self.handleAnyError(with: error)))
            }
        }
        
        task.resume()
    }
    
    private func handleHTTPResponse(data: Data, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.invalidResponse
        }
        return data
    }
    
    private func handleAnyError(with error: Error) -> ServiceError {
        if let serviceError = error as? ServiceError {
            return serviceError
        } else if error is DecodingError {
            return .decodableError
        } else {
            return .networkError
        }
    }
}
