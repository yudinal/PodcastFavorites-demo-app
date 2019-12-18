//
//  Podcast.swift
//  PodcastFavorites demo app
//
//  Created by Lilia Yudina on 12/16/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

struct Podcasts: Decodable {
    let results: [Podcast]
}

struct Podcast: Decodable {
let collectionId: Int
let trackId: Int
let artistName: String
let collectionName: String
let trackName: String
let artworkUrl30: String
let artworkUrl60: String
let artworkUrl100: String
let releaseDate: String
let collectionExplicitness: String
let trackExplicitness: String
let trackCount: Int
let primaryGenreName: String
let artworkUrl600: String
let favoritedBy: String?
}

