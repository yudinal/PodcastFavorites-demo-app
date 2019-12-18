//
//  ViewController.swift
//  PodcastFavorites demo app
//
//  Created by Lilia Yudina on 12/16/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {

    @IBOutlet weak var podcastTableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!

    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.podcastTableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            PodcastAPIClient.getPodcast(for: searchQuery) { (result) in
                switch result {
                case .failure(let appError):
                print(appError)
                case .success(let podcasts):
                    self.podcasts = podcasts
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        podcastTableView.dataSource = self
        podcastTableView.delegate = self
        searchbar.delegate = self
    }
    
    
    func filterPodcasts(for searchText: String) {
        guard !searchText.isEmpty else {return}
        PodcastAPIClient.getPodcast(for: searchText) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let podcasts):
                self.podcasts = podcasts
            }
        }
    }

}

extension PodcastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
           fatalError("Couldn't dequeue a PodcastCell")        }
      
        let podcast = podcasts[indexPath.row]
        
        cell.configureCell(for: podcast)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension PodcastViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
         guard let searchText = searchBar.text else {
            return
        }
            searchQuery = searchText
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
           searchQuery = searchText.lowercased()
           
       }
   
}
