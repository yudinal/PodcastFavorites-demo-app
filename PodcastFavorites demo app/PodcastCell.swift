//
//  PodcastCell.swift
//  PodcastFavorites demo app
//
//  Created by Lilia Yudina on 12/17/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
   
    func configureCell(for podcast: Podcast) {
        collectionNameLabel.text = podcast.collectionName
        artistNameLabel.text = podcast.artistName
        
        genreLabel.text = podcast.primaryGenreName
        
        podcastImage.getImage(with: podcast.artworkUrl100) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImage.image = image
                }
            }
        }
    }
    
}
