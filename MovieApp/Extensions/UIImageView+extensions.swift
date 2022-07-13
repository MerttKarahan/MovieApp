//
//  UIImageView+extensions.swift
//  MovieApp
//
//  Created by Mert Karahan on 9.06.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(poster_path: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + poster_path)
        self.kf.setImage(with: url)
    }
}


