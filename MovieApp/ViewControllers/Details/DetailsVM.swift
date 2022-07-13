//
//  DetailsVM.swift
//  MovieApp
//
//  Created by Mert Karahan on 13.06.2022.
//

import Foundation
import Alamofire

final class DetailsVM: BaseVM {

    var detailsItemResponse: DetailResponseModel?{
        didSet {
            self.successOperation?()
        }
    }
    
    var similarResponse: SimilarResponse?{
        didSet{
            self.successOperation?()
        }
    }
    
    
    var videoResponse: VideoResponse?{
        didSet {
            self.successOperation?()
        }
    }
    
    
    
    var numberOfSimilarItems: Int {
        self.similarResponse?.results.count ?? 0
    }
    
    let id: String
    let type: String?
    let adult : Bool?
    init(Id: String, Type: String, adult: Bool?) {
        self.id = Id
        self.type = Type
        self.adult = adult
    }
    
    func getTrendItemDetailsFromMovieApiOperation(page: Int = 1) {
        if adult != nil{
            MovieAppOperations.sharedInstance.getMovieDetail(movieId: self.id) { response in
                switch response {
                case .success(let successResponse):
                    self.detailsItemResponse = successResponse
                case .failure(let error):
                    self.errorOperation?(error)
                }
            }
            
            MovieAppOperations.sharedInstance.getSimilarMovies(movieId: self.id, page: page) { response in
                switch response {
                case .success(let successResponse):
                    
                    if self.similarResponse == nil {
                        self.similarResponse = successResponse
                    } else {
                        self.similarResponse?.page = successResponse.page
                        self.similarResponse?.results.append(contentsOf: successResponse.results)
                        self.successOperation?()
                    }
                case .failure(let error):
                    self.errorOperation?(error)
                }
            }
            
            MovieAppOperations.sharedInstance.getMovieVideo(movieId: self.id) { response in
                switch response {
                case.success(let successResponse):
                    self.videoResponse = successResponse
                case .failure(let error):
                    self.errorOperation?(error)
                }
            }
            
        } else if adult == nil {
            MovieAppOperations.sharedInstance.getTvShowDetails(tvId: self.id) { response in
                switch response {
                case .success(let successResponse):
                    self.detailsItemResponse = successResponse
                case .failure(let error):
                    self.errorOperation?(error)
                }
            }
            
            MovieAppOperations.sharedInstance.getSimilarTvShows(TvId: self.id, page: page) { response in
                switch response {
                case .success(let successResponse):
                    
                    if self.similarResponse == nil {
                        self.similarResponse = successResponse
                    } else {
                        self.similarResponse?.page = successResponse.page
                        self.similarResponse?.results.append(contentsOf: successResponse.results)
                        self.successOperation?()
                    }
                case .failure(let error):
                    self.errorOperation?(error)
                }
            }
            
            MovieAppOperations.sharedInstance.getTvShowVideo(tvId: self.id) { response in
                switch response {
                case.success(let successResponse):
                    self.videoResponse = successResponse
                case .failure(let error):
                    self.errorOperation?(error)
                }
            }
        }
    }
    
    func similarItem(at index: Int) -> SimilarItem? {
        return self.similarResponse?.results[index]
    }
    
    func pagination() {
        getTrendItemDetailsFromMovieApiOperation(page: (similarResponse?.page ?? 1) + 1)
    }
    
}




