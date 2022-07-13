//
//  TrendItemsVM.swift
//  MovieApp
//
//  Created by Mert Karahan on 8.06.2022.
//

import Foundation


final class TrendItemsVM: BaseVM {
    

    
    private var trendItemResponse: TrendItemsResponse? {
        didSet {
            self.successOperation?()
        }
    }
    
    var numberOfTrendItems: Int {
        self.trendItemResponse?.results.count ?? 0
    }
    
    func getTrendItemsFromMovieApiOperation(page: Int = 1) {
        
        MovieAppOperations.sharedInstance.getTrendItems(page: page) { response in
            switch response {
            case .success(let successResponse):
                
                if self.trendItemResponse == nil {
                    self.trendItemResponse = successResponse
                } else {
                    self.trendItemResponse?.page = successResponse.page
                    self.trendItemResponse?.results.append(contentsOf: successResponse.results)
                    self.successOperation?()
                }
            case .failure(let error):
                self.errorOperation?(error)
            }
        }
    }
    
    func getPopularMovies(page: Int = 1) {
        
        MovieAppOperations.sharedInstance.getPopularMovies(page: page) { response in
            switch response {
            case .success(let successResponse):
                
                if self.trendItemResponse == nil {
                    self.trendItemResponse = successResponse
                } else {
                    self.trendItemResponse?.page = successResponse.page
                    self.trendItemResponse?.results.append(contentsOf: successResponse.results)
                    self.successOperation?()
                }
            case .failure(let error):
                self.errorOperation?(error)
            }
        }
    }
    
    func getPopularTvShows(page: Int = 1){
        MovieAppOperations.sharedInstance.getPopularTvShows(page: page) { response in
            switch response {
            case .success(let successResponse):
                
                if self.trendItemResponse == nil {
                    self.trendItemResponse = successResponse
                } else {
                    self.trendItemResponse?.page = successResponse.page
                    self.trendItemResponse?.results.append(contentsOf: successResponse.results)
                    self.successOperation?()
                }
            case .failure(let error):
                self.errorOperation?(error)
            }
        }
    }
    
    func getTopRatedMovies(page: Int = 1) {
        MovieAppOperations.sharedInstance.getTopRatedMovies(page: page) { response in
            switch response {
            case .success(let successResponse):
                
                if self.trendItemResponse == nil {
                    self.trendItemResponse = successResponse
                } else {
                    self.trendItemResponse?.page = successResponse.page
                    self.trendItemResponse?.results.append(contentsOf: successResponse.results)
                    self.successOperation?()
                }
            case .failure(let error):
                self.errorOperation?(error)
            }
        }
        
    }
    
    func getTopRatedTvShows(page: Int = 1) {
        MovieAppOperations.sharedInstance.getTopRatedTvShows(page: page) { response in
            switch response {
            case .success(let successResponse):
                
                if self.trendItemResponse == nil {
                    self.trendItemResponse = successResponse
                } else {
                    self.trendItemResponse?.page = successResponse.page
                    self.trendItemResponse?.results.append(contentsOf: successResponse.results)
                    self.successOperation?()
                }
            case .failure(let error):
                self.errorOperation?(error)
            }
        }
        
    }
    
    func getUpcomingMovies(page : Int = 1) {
        MovieAppOperations.sharedInstance.getUpcomingMovies(page: page) { response in
            switch response {
            case .success(let successResponse):
                
                if self.trendItemResponse == nil {
                    self.trendItemResponse = successResponse
                } else {
                    self.trendItemResponse?.page = successResponse.page
                    self.trendItemResponse?.results.append(contentsOf: successResponse.results)
                    self.successOperation?()
                }
            case .failure(let error):
                self.errorOperation?(error)
            }
        }
    }
    
    func getSearchItems(page : Int = 1, text: String) {
        MovieAppOperations.sharedInstance.getSearchItems(searchText: text, page: page) { response in
            switch response {
            case .success(let successResponse):

                    self.trendItemResponse = successResponse

            case .failure(let error):
                self.errorOperation?(error)
            }
        }
    }
    
    func pagination() {
        getTrendItemsFromMovieApiOperation(page: (trendItemResponse?.page ?? 1) + 1)
    }
    
    func trendItem(at index: Int) -> TrendItem? {
        return self.trendItemResponse?.results[index]
    }
    

    
}


