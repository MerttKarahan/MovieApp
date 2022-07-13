//
//  DetailCell.swift
//  MovieApp
//
//  Created by Mert Karahan on 13.06.2022.
//

import UIKit

class DetailCell: UICollectionViewCell {

    @IBOutlet weak var similarImage: UIImageView!
    @IBOutlet weak var similarMovieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func similarItemConfigure(similarMovies: SimilarItem) {
        similarImage.setImage(poster_path: similarMovies.poster_path ?? "")
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
