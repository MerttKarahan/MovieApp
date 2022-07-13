//
//  DetailsVC.swift
//  MovieApp
//
//  Created by Mert Karahan on 9.06.2022.
//

import UIKit
import YouTubeiOSPlayerHelper

class DetailsVC: UIViewController {
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var episode: UILabel!
    
    @IBOutlet weak var similarCollectionView: UICollectionView!
    
    var viewModel: DetailsVM?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCollectionView()
        viewModel?.getTrendItemDetailsFromMovieApiOperation()
        
        viewModel?.successOperation = {
            if let response = self.viewModel?.detailsItemResponse {
                DispatchQueue.main.async {
                    self.configure(detailsItem: response)
                    self.similarCollectionView.reloadData()
                }
            }
            
        }
    }
    
    func configure(detailsItem: DetailResponseModel) {
        if viewModel?.type == "movie" {
            runtime.text = "\(detailsItem.runtime?.description ?? "0") min."
        } else {
            runtime.text = "Season: \(detailsItem.number_of_seasons?.description ?? "0")   Episode: \(detailsItem.number_of_episodes?.description ?? "0")"
        }
        date.text = detailsItem.release_date ?? detailsItem.first_air_date
        originalTitle.text = detailsItem.original_title ?? detailsItem.original_name
        tagline.text = detailsItem.tagline
        voteAverage.text = detailsItem.vote_average?.description
        overView.text = detailsItem.overview
        language.text = detailsItem.original_language?.uppercased()
        movieImage.setImage(poster_path: detailsItem.poster_path ?? "")
        movieImage.layer.cornerRadius = 8.0
        playerView.load(withVideoId: viewModel?.videoResponse?.results.first?.key ?? "vYsQ5mu5Xow")

        
    }
    
    private func setupCollectionView() {
        self.similarCollectionView.delegate = self
        self.similarCollectionView.dataSource = self
        // Collection view da kullanılacak Custom Cell'i tanıtma
        self.similarCollectionView.register(UINib(nibName: "DetailCell", bundle: nil), forCellWithReuseIdentifier: "DetailCell")
    }
}

extension DetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel?.similarResponse?.results[indexPath.row].id,
              let adult = viewModel?.adult,
              let type = viewModel?.type else {
            return
        }
        
        let detailsVC = DetailsBuilder.build(id: id.description, type: type, adult: adult)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel?.numberOfSimilarItems ?? 0) - 1 {
            viewModel?.pagination()
        }
    }
}

extension DetailsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfSimilarItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = similarCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailCell
        
        if let similarItem = viewModel?.similarItem(at: indexPath.row) {
            cell.similarItemConfigure(similarMovies: similarItem)
            cell.layer.cornerRadius = 8.0
            cell.layer.masksToBounds = true

        }
        return cell
    }
}

extension DetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        Her bir cellin boyutunu belirleme

        return CGSize(width: 134 , height: 201)
    }
}

