//
//  TrendItemsModel.swift
//  MovieApp
//
//  Created by Mert Karahan on 8.06.2022.
//

import Foundation
import UIKit

struct TrendItem: Decodable {
    
    let title : String?
    let original_name : String?
    let media_type : String?
    let poster_path : String?
    let id : Int?
    let adult : Bool?
    
}

struct TrendItemsResponse: Decodable {
    var page: Int
    var results: [TrendItem]
}
