//
//  URLSession+Service.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/14/22.
//

import Foundation
import RxSwift

extension URLSession {
    func dataTask<T: Decodable>(with url: URL) -> Observable<T> {
        rx.response(request: URLRequest(url: url))
            .map { result throws -> Data in
                guard result.response.statusCode == 200 else {
                    throw APIServiceError.apiError
                }
                return result.data
            }.map { data throws -> T in
                do {
                    let decodedDataResponse = try JSONDecoder().decode(
                        T.self, from: data)
                    return decodedDataResponse
                } catch let error {
                    throw APIServiceError.decodeError
                }
            }
    }

    func decodeData<T: Decodable>(with data: Data) throws -> T {
        do {
            let decodedDataResponse = try JSONDecoder().decode(
                T.self, from: data)
            return decodedDataResponse
        } catch let error {
            throw APIServiceError.decodeError
        }
    }
}

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
    case invalidURL
    case networkError
}
