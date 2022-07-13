//
//  TrendItemsVC.swift
//  MovieApp
//
//  Created by Mert Karahan on 8.06.2022.
//

import UIKit
import SideMenu

class TrendItemsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedType : SelectedType?
    var viewModel = TrendItemsVM()
    private let sideMenu = SideMenuNavigationController(rootViewController: SideMenuVc())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch selectedType {
        case.search:
            setupSearchBar()
        case.trend:
            viewModel.getTrendItemsFromMovieApiOperation()
            navigationItem.title = "Trend"
        case.upcomingMovies:
            viewModel.getUpcomingMovies()
            navigationItem.title = "Upcoming Movies"
        case.topRatedTvShows:
            viewModel.getTopRatedTvShows()
            navigationItem.title = "Top Rated Tv Shows"
        case.topRatedMovies:
            viewModel.getTopRatedMovies()
            navigationItem.title = "Top Rated Movies"
        case.popularTvShows:
            viewModel.getPopularTvShows()
            navigationItem.title = "Popular Tv Shows"
        case.popularMovies:
            viewModel.getPopularMovies()
            navigationItem.title = "Popular Movies"
        default:
            break
        }
        
        setupCollectionView()
        navigationBarItems()
        sideMenuManager()
        
        viewModel.successOperation = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.errorOperation = { error in
            print(error.errorDescription)
        }
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Collection view da kullanılacak Custom Cell'i tanıtma
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
    }
    private func setupSearchBar() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.tintColor = UIColor(red: 199/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1)
    }
    
    
    private func navigationBarItems() {
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.plain, target: self, action: #selector(menuClicked))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: nil)

    }
    
    func sideMenuManager() {
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    @objc func menuClicked() {
        present(sideMenu, animated: true)
    }

    
}


extension TrendItemsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedData = self.viewModel.trendItem(at: indexPath.row)
        
        if let selectedDataId = selectedData?.id {
            let detailsVC = DetailsBuilder.build(id: selectedDataId.description, type: selectedData?.media_type ?? "" , adult: selectedData?.adult)
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfTrendItems - 1 {
            viewModel.pagination()
        }
    }
    
    
}

extension TrendItemsVC: UICollectionViewDataSource {
    // Section sayısı
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Bir Section daki item sayısı
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfTrendItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        if let trendItem = viewModel.trendItem(at: indexPath.row) {
            cell.configure(trendItem: trendItem)
            cell.layer.cornerRadius = 20
            cell.layer.masksToBounds = true
            let colorTop =  UIColor(red: 199/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 104/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0).cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = cell.bounds
            cell.layer.insertSublayer(gradientLayer, at: 0)
        }
        return cell
    }
    
}

extension TrendItemsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        Her bir cellin boyutunu belirleme
        let cellWidth = (UIScreen.main.bounds.width - 10) / 2
        return CGSize(width: cellWidth, height: cellWidth * 1.5)
    }
}

extension TrendItemsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchText == " " {
            collectionView.isHidden = true
        } else {
            collectionView.isHidden = false
            viewModel.getSearchItems(text: searchText)
        }

  
    }
}
