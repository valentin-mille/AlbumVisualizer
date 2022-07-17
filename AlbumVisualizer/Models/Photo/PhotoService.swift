//
//  PhotoService.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/15/22.
//

import Foundation
import RxSwift

struct PhotoParams {
    let albumId: Int
    let page: Int

    init(albumId: Int, page: Int) {
        self.albumId = albumId
        self.page = page
    }
}

enum PhotoService {
    static func getPhotos(params: PhotoParams) -> Observable<[Photo]> {
        guard var urlComponent = URLComponents(string: EndPoints.Photos) else {
            return Observable.error(APIServiceError.invalidURL)
        }

        urlComponent.queryItems = [
            URLQueryItem(name: "albumId", value: String(params.albumId)),
            URLQueryItem(name: "page", value: String(params.page))
        ]
        urlComponent.percentEncodedQuery = urlComponent.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        guard let url = urlComponent.url else {
            return Observable.error(APIServiceError.invalidURL)
        }

        return URLSession.shared.dataTask(with: url)
    }
}
