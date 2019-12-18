//
//  FavoritePodcastAPIClient.swift
//  PodcastFavorites demo app
//
//  Created by Lilia Yudina on 12/17/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

struct FavoritePodcastAPIClient {
    func getFavoritePodcast(completion: @escaping (Result<[Podcast], AppError>) -> ()) {
        let endpointURLString = "tps://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
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
                    let favoritePodcast = searches.results
                    completion(.success(favoritePodcast))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
            
        }
    }
    static func postFavoritePodcast(favoritePodcast: PostedFavoritePodcast, completion: @escaping (Result<Bool,AppError>) -> ()) {
        let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: endpointURLString) else {
                   completion(.failure(.badURL(endpointURLString)))
                   return
               }
               
              
                    do {
                let data = try JSONEncoder().encode(favoritePodcast)
                        var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = data
                NetworkHelper.shared.performDataTask(with: request) { (result) in
                    switch result {
                    case .failure(let appError):
                        completion(.failure(.networkClientError(appError)))
                    case .success:
                        completion(.success(true))
                    }
                }
            } catch {
                completion(.failure(.encodingError(error)))
            }
        }
    }

