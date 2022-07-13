//
//  MovieApiOperations.swift
//  MovieApp
//
//  Created by Mert Karahan on 8.06.2022.
//

import Foundation
import Alamofire

struct APIConstants {
    static var baseURL = "https://api.themoviedb.org/3"
    static var api_key: [String: Any] = ["api_key": "578da68e9b251f54713c69cb126db0d5"]
    static var page: [String:Any] = ["page" : "1"]
    static var movie_id : [String : Any] = ["movie_id" : ""]
    static var tv_id : [String : Any] = ["tv_id" : ""]
}


enum MovieAPIPaths: String {
    case trendItems = "/trending/all/week"
    case popularMovies = "/movie/popular"
    case popularTvShows = "/tv/popular"
    case topRatedMovies = "/movie/top_rated"
    case topRatedTvShows = "/tv/top_rated"
    case upcomingMovies = "/movie/upcoming"
    case movieDetail = "/movie/%%"
    case tvDetail = "/tv/%%"
    case similarMovie = "/movie/%%/similar"
    case similarTv = "/tv/%%/similar"
    case movieVideo = "/movie/%%/videos"
    case tvShowVideo = "/tv/%%/videos"
    case search = "/search/multi"
    
    var fullPath: String {
        return APIConstants.baseURL + self.rawValue
    }
    
    func fullPathWith(parameter: String) -> String {
        // replacingOccurrences string içerisinde verilen yere verilen string'i basar
        return APIConstants.baseURL + self.rawValue.replacingOccurrences(of: "%%", with: parameter)
    }
}

class MovieAppOperations {
    
    static var sharedInstance = MovieAppOperations()
    
    func getTrendItems(page: Int, finishGetTrendItems: @escaping ((Result<TrendItemsResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.trendItems.fullPath,
                                 method: .get,
                                 parameters: newPage, //  Parametreler
                                 encoding: URLEncoding.default, // Parametreler URL de mi Body'de mi gidecek
                                 headers: nil)
        
        request.responseDecodable(of: TrendItemsResponse.self) { response in
            if let value = response.value {
                finishGetTrendItems(.success(value))
            } else if let error = response.error {
                finishGetTrendItems(.failure(error))
            }
        }
    }
    
    
    
    
    
    
    
    
    func getMovieDetail(movieId: String, finishGetMovieDetails: @escaping ((Result<DetailResponseModel, AFError>) -> Void)) {
        
        let request = AF.request(MovieAPIPaths.movieDetail.fullPathWith(parameter: movieId),
                                 method: .get,
                                 parameters: APIConstants.api_key,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: DetailResponseModel.self) {response in
            if let value = response.value {
                finishGetMovieDetails(.success(value))
            } else if let error = response.error {
                finishGetMovieDetails(.failure(error))
            }
        }
    }
    
    
    
    
    
    
    
    func getTvShowDetails(tvId: String, finishGetTvShowDetails: @escaping ((Result<DetailResponseModel, AFError>) -> Void)) {
        
        let request = AF.request(MovieAPIPaths.tvDetail.fullPathWith(parameter: tvId),
                                 method: .get,
                                 parameters: APIConstants.api_key,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: DetailResponseModel.self) { response in
            if let value = response.value {
                finishGetTvShowDetails(.success(value))
            } else if let error = response.error {
                finishGetTvShowDetails(.failure(error))
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    func getSimilarMovies(movieId: String, page: Int, finishGetSimilarMovies: @escaping ((Result<SimilarResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.similarMovie.fullPathWith(parameter: movieId),
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: SimilarResponse.self) { response in
            if let value = response.value {
                finishGetSimilarMovies(.success(value))
            } else if let error = response.error {
                finishGetSimilarMovies(.failure(error))
            }
        }
        
        
        
    }
    
    
    
    
    
    
    func getSimilarTvShows(TvId: String, page: Int, finishGetSimilarTvShows: @escaping ((Result<SimilarResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.similarTv.fullPathWith(parameter: TvId),
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: SimilarResponse.self) { response in
            if let value = response.value {
                finishGetSimilarTvShows(.success(value))
            } else if let error = response.error {
                finishGetSimilarTvShows(.failure(error))
            }
        }
        
        
        
    }
    
    
    func getMovieVideo(movieId: String, finishGetMovieVideo: @escaping ((Result<VideoResponse, AFError>) -> Void)) {
        
        let request = AF.request(MovieAPIPaths.movieVideo.fullPathWith(parameter: movieId),
                                 method: .get,
                                 parameters: APIConstants.api_key,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: VideoResponse.self) { response in
            if let value = response.value {
                finishGetMovieVideo(.success(value))
            } else if let error = response.error {
                finishGetMovieVideo(.failure(error))
            }
        }
    }
    
    
    func getTvShowVideo(tvId: String, finishGetTvShowVideo: @escaping ((Result<VideoResponse, AFError>) -> Void)) {
        
        let request = AF.request(MovieAPIPaths.tvShowVideo.fullPathWith(parameter: tvId),
                                 method: .get,
                                 parameters: APIConstants.api_key,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: VideoResponse.self) { response in
            if let value = response.value {
                finishGetTvShowVideo(.success(value))
            } else if let error = response.error {
                finishGetTvShowVideo(.failure(error))
            }
        }
    }
    
    
    func getPopularMovies(page: Int, finishGetPopularMovies: @escaping((Result<TrendItemsResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.popularMovies.fullPath,
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: TrendItemsResponse.self) {response in
            if let value = response.value {
                finishGetPopularMovies(.success(value))
            } else if let error = response.error {
                finishGetPopularMovies(.failure(error))
            }
        }
    }
    
    
    
    func getPopularTvShows(page: Int, finishGetPopularTvShows: @escaping((Result<TrendItemsResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.popularTvShows.fullPath,
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: TrendItemsResponse.self) {response in
            if let value = response.value {
                finishGetPopularTvShows(.success(value))
            } else if let error = response.error {
                finishGetPopularTvShows(.failure(error))
            }
        }
    }
    
    
    
    func getTopRatedMovies(page: Int, finishGetTopRatedMovies: @escaping((Result<TrendItemsResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.topRatedMovies.fullPath,
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: TrendItemsResponse.self) {response in
            if let value = response.value {
                finishGetTopRatedMovies(.success(value))
            } else if let error = response.error {
                finishGetTopRatedMovies(.failure(error))
            }
        }
    }
    
    
    func getTopRatedTvShows(page: Int, finishGetTopRatedTvShows: @escaping((Result<TrendItemsResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.topRatedTvShows.fullPath,
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: TrendItemsResponse.self) {response in
            if let value = response.value {
                finishGetTopRatedTvShows(.success(value))
            } else if let error = response.error {
                finishGetTopRatedTvShows(.failure(error))
            }
        }
    }
    
    
    
    
    func getUpcomingMovies(page: Int, finishGetUpcomingMovies: @escaping((Result<TrendItemsResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        newPage.merge(dict: APIConstants.api_key)
        
        let request = AF.request(MovieAPIPaths.upcomingMovies.fullPath,
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: TrendItemsResponse.self) {response in
            if let value = response.value {
                finishGetUpcomingMovies(.success(value))
            } else if let error = response.error {
                finishGetUpcomingMovies(.failure(error))
            }
        }
    }

    
    func getSearchItems(searchText: String, page: Int, finishGetSearchItems: @escaping((Result<TrendItemsResponse, AFError>) -> Void)) {
        
        var newPage = APIConstants.page
        newPage["page"] = String(page)
        newPage.merge(dict: APIConstants.api_key)
        newPage.merge(dict: ["query": searchText])
        
        let request = AF.request(MovieAPIPaths.search.fullPath,
                                 method: .get,
                                 parameters: newPage,
                                 encoding: URLEncoding.default,
                                 headers: nil)
        
        request.responseDecodable(of: TrendItemsResponse.self) {response in
            if let value = response.value {
                finishGetSearchItems(.success(value))
            } else if let error = response.error {
                finishGetSearchItems(.failure(error))
            }
        }
        
    }
    
    
    
    
    
    
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
