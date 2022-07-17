//
//  PhotoService.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/15/22.
//

import Foundation

struct PhotoParams {
    let albumId: Int
    let page: Int

    init(albumId: Int, page: Int) {
        self.albumId = albumId
        self.page = page
    }
}

enum PhotoService {
    static func getPhotos(params: PhotoParams, completion: @escaping (Result<[Photo], APIServiceError>) -> Void) {
        guard var url = URLComponents(string: EndPoints.Albums) else {
            completion(.failure(.invalidURL))
            return
        }

        url.queryItems = [
            URLQueryItem(name: "albumId", value: String(params.albumId)),
            URLQueryItem(name: "page", value: String(params.page))
        ]
        url.percentEncodedQuery = url.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        URLSession.shared.resumeDataTask(with: url.url!, withTypedResponse: completion)
    }
}
