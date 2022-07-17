//
//  PhotosModel.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/15/22.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case albumId
        case title
        case url
        case thumbnailURL
    }
}
