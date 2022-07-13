//
//  Dictionary+extensions.swift
//  MovieApp
//
//  Created by Mert Karahan on 10.06.2022.
//

import Foundation



extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
