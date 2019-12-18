//
//  PodcastAPIClient.swift
//  PodcastFavorites demo app
//
//  Created by Lilia Yudina on 12/16/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

struct PodcastAPIClient {
    static func getPodcast(for search: String, completion: @escaping(Result<[Podcast], AppError>) -> ()) {
        let endpointURLString = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(search)"
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searches = try JSONDecoder().decode(Podcasts.self, from: data)
                    let podcasts = searches.results
                    completion(.success(podcasts))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
