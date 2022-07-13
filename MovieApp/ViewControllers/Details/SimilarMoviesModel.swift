//
//  SimilarMoviesModel.swift
//  MovieApp
//
//  Created by Mert Karahan on 13.06.2022.
//

import Foundation

struct SimilarItem : Decodable {
    let original_title : String?
    let poster_path : String?
    let original_name : String?
    let id : Int?
}

struct SimilarResponse : Decodable {
    var page: Int
    var results: [SimilarItem]
}
