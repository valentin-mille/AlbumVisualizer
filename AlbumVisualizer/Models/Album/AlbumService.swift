//
//  AlbumService.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/15/22.
//

import Foundation
import RxSwift

class AlbumService {
    func getAlbums(completion: @escaping (Result<[Album], APIServiceError>) -> Void) {
        guard let url = URL(string: EndPoints.Albums) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.resumeDataTask(with: url, withTypedResponse: completion)
    }

    func getAlbumsRx() -> Observable<[Album]> {
        let url = URL(string: EndPoints.Albums)!
        return URLSession.shared.rx.response(request: URLRequest(url: url))
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw APIServiceError.apiError
                }
                return result.data
            }.map { data -> [Album] in
                do {
                    let albums = try JSONDecoder().decode(
                        [Album].self, from: data)
                    return albums
                } catch let error {
                    throw APIServiceError.decodeError
                }
            }
//        return URLSession.shared.rx
//            .json(url: url)
//            .flatMap { data throws -> Observable<[Album]> in
//
//                let decoder = JSONDecoder()
//                do {
//                    let albums = try decoder.decode([Album].self, from: data as! Data)
//                    return Observable.just(albums)
//                } catch (let error) {
//                    return Observable.error(APIServiceError.apiError)
//                }
//            }
    }
}
