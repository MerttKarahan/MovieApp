//
//  DetailsModel.swift
//  MovieApp
//
//  Created by Mert Karahan on 13.06.2022.
//

import Foundation

struct DetailResponseModel : Decodable {
    let poster_path : String?
    let original_title : String?
    let overview : String?
    let tagline : String?
    let vote_average : Double?
    let release_date : String?
    let original_language : String?
    let runtime : Int?
    let number_of_episodes: Int?
    let number_of_seasons: Int?
    let original_name: String?
    let first_air_date: String?
    
}

