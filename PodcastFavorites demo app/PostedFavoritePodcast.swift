//
//  PostedFavoritePodcast.swift
//  PodcastFavorites demo app
//
//  Created by Lilia Yudina on 12/17/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

struct PostedFavoritePodcast: Encodable {
    let trackId: Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
}
