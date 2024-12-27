//
//  AsyncAwaitService.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//

import Foundation

enum ServiceError: Error {
    case badURL
    case decodableError
    case emptyResponse
    case invalidResponse
    case networkError
}

protocol ServiceAsync {
    func fetchData<T: Decodable>(url: URL) async throws -> T
}

class AsyncAwaitService: ServiceAsync {
    func fetchData<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try validateHTTPResponse(with: response)
            guard !data.isEmpty else { throw ServiceError.emptyResponse }
            return try decodeData(with: data)
        } catch let error as ServiceError {
            throw error
        } catch {
            throw ServiceError.networkError
        }
    }
    
    private func validateHTTPResponse(with response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.invalidResponse
        }
    }
    
    private func decodeData<T: Decodable>(with data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw ServiceError.decodableError
        }
    }
}
