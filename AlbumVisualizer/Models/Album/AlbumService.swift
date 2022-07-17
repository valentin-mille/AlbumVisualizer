//
//  AlbumService.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/15/22.
//

import Foundation
import RxSwift

class AlbumService {
    func getAlbums() -> Observable<[Album]> {
        guard let url = URL(string: EndPoints.Albums) else {
            return Observable.error(APIServiceError.invalidURL)
        }
        return URLSession.shared.dataTask(with: url)
    }
}
