//
//  Response.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/17/22.
//

import Foundation

struct Response<T> {
    let data: T?
    let isSuccess: Bool
    let error: Error?
}
