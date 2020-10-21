//
//  APIClient.swift
//  MovieApp
//
//  Created by Burak KAYA on 20.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire

public protocol APIClientProtocol {
    func fetchMoviesNowPlaying(completion:@escaping (Result<MovieDbRes, AFError>)->Void)
    func fetchMoviesUpcoming(completion:@escaping (Result<MovieDbRes, AFError>)->Void)
    func fetchMoviesSearch(searchText : String, completion:@escaping (Result<MovieDbRes, AFError>)->Void)
    func fetchMovieDetail(id: Int,completion:@escaping (Result<MovieDetail, AFError>)->Void)
    func fetchMoviesSimilar(id: Int,completion:@escaping (Result<MovieDbRes, AFError>)->Void)
}

class APIClient: APIClientProtocol {

    func fetchMoviesNowPlaying(completion: @escaping (Result<MovieDbRes, AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.now_playing) { (result) in
            completion(result)
        }
    }
    
    func fetchMoviesUpcoming(completion: @escaping (Result<MovieDbRes, AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.upcoming) { (result) in
            completion(result)
        }
    }
    
    func fetchMoviesSearch(searchText: String, completion: @escaping (Result<MovieDbRes, AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.search(searchText: searchText)) { (result) in
            completion(result)
        }
    }
    
    func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.detail(id: id)) { (result) in
            completion(result)
        }
    }
    
    func fetchMoviesSimilar(id: Int, completion: @escaping (Result<MovieDbRes, AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.similar(id: id)) { (result) in
            completion(result)
        }
    }
    
    
    @discardableResult
    public static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route).validate()
        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}
