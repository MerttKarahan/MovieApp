//
//  VideoModel.swift
//  MovieApp
//
//  Created by Mert Karahan on 14.06.2022.
//

import Foundation

struct VideoResponseItem : Decodable {
    let key : String
}

struct VideoResponse : Decodable {
    let id : Int
    let results : [VideoResponseItem]
}
