//
//  SideMenuVc.swift
//  MovieApp
//
//  Created by Mert Karahan on 18.06.2022.
//

import UIKit

class SideMenuVc: UIViewController {

    @IBOutlet weak var sideMenuTableView: UITableView!
    var items = ["Search", "Trend", "Popular Tv Shows","Popular Movies","Top Rated Tv Shows", "Top Rated Moives", "Upcoming Movies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
    
    
    private func setupTableView() {
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = .systemGray6
        
    }
    

}

extension SideMenuVc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.items[indexPath.row]
        cell.contentView.backgroundColor = UIColor(red: 153, green: 102, blue: 153 ,alpha: 0.3)
        return cell
    }
    
    
}


extension SideMenuVc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedEnum = SelectedType(rawValue: indexPath.row)
        
        let trendItemsVC = TrendItemsVC()
        let navigationController = UINavigationController(rootViewController: trendItemsVC)
        UIApplication.window?.rootViewController = navigationController
        
        trendItemsVC.selectedType = selectedEnum
        
        
    }
}
