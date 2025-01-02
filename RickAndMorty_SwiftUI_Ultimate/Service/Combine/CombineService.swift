//
//  CombineService.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//

import Foundation
import Combine

protocol CombineService {
    func fetchData<T: Decodable>(url: URL?) -> AnyPublisher<T, ServiceError>
}

class CombineServiceImpl: CombineService {
    func fetchData<T: Decodable>(url: URL?) -> AnyPublisher<T, ServiceError> {
        guard let url else {
            return Fail(error: ServiceError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                try self.handleHTTPResponse(with: output)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                self.handleAnyError(with: error)
            }
            .eraseToAnyPublisher()
    }
    
    private func handleHTTPResponse(with response: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.invalidResponse
        }
        guard !response.data.isEmpty else {
            throw ServiceError.emptyResponse
        }
        return response.data
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
