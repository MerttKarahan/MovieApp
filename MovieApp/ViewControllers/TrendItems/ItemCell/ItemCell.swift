//
//  ItemCell.swift
//  MovieApp
//
//  Created by Mert Karahan on 8.06.2022.
//

import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(trendItem: TrendItem) {
        typeLabel.text = trendItem.media_type?.uppercased()
        nameLabel.text = trendItem.title ?? trendItem.original_name
        itemImageView.setImage(poster_path: trendItem.poster_path ?? "")
        
    }

}
