//
//  SplashVC.swift
//  MovieApp
//
//  Created by Mert Karahan on 8.06.2022.
//

import UIKit

class SplashVC: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let trendItemsVC = TrendItemsVC()
        let navigationController = UINavigationController(rootViewController: trendItemsVC)
        UIApplication.window?.rootViewController = navigationController
    }

}
