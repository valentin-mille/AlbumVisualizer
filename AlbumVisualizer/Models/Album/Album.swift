//
//  AlbumModel.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/15/22.
//

import Foundation

struct Album: Codable {
    let id: Int
    let userId: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
    }
}
