//
//  DetailsBuilder.swift
//  MovieApp
//
//  Created by Mert Karahan on 13.06.2022.
//

import Foundation

struct DetailsBuilder {
    static func build(id: String, type: String, adult: Bool?) -> DetailsVC {
        //            DetailsVM içerisine movieId vererek oluşturuldu
        let detailsVM = DetailsVM(Id: id, Type: type, adult: adult)
        let detailsVC = DetailsVC()
        detailsVC.viewModel = detailsVM
        return detailsVC
    }
    
}

