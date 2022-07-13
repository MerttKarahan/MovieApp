//
//  BaseVM.swift
//  MovieApp
//
//  Created by Mert Karahan on 13.06.2022.
//

import Foundation
import Alamofire

class BaseVM {
    var successOperation: (() -> Void)?
    var errorOperation: ((AFError) -> Void)?
}
