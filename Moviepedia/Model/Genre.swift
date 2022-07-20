//
//  Genre.swift
//  Moviepedia
//
//  Created by mccl on 19/07/22.
//

import Foundation

struct GenreId: Codable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [GenreId]
}
