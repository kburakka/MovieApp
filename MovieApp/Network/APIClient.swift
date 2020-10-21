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
    func fetchMoviesNowPlaying(completion:@escaping (Result<MovieDbRes, Error>)->Void)
    func fetchMoviesUpcoming(completion:@escaping (Result<MovieDbRes, Error>)->Void)
    func fetchMoviesSearch(searchText : String, completion:@escaping (Result<MovieDbRes, Error>)->Void)
    func fetchMovieDetail(id: Int,completion:@escaping (Result<MovieDetail, Error>)->Void)
    func fetchMoviesSimilar(id: Int,completion:@escaping (Result<MovieDbRes, Error>)->Void)
}

class APIClient: APIClientProtocol {
    
    func fetchMoviesNowPlaying(completion: @escaping (Result<MovieDbRes, Error>) -> Void) {
        APIClient.performRequest(route: APIRouter.now_playing) { (result) in
            completion(result)
        }
    }
    
    func fetchMoviesUpcoming(completion: @escaping (Result<MovieDbRes, Error>) -> Void) {
        APIClient.performRequest(route: APIRouter.upcoming) { (result) in
            completion(result)
        }
    }
    
    func fetchMoviesSearch(searchText: String, completion: @escaping (Result<MovieDbRes, Error>) -> Void) {
        APIClient.performRequest(route: APIRouter.search(searchText: searchText)) { (result) in
            completion(result)
        }
    }
    
    func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        APIClient.performRequest(route: APIRouter.detail(id: id)) { (result) in
            completion(result)
        }
    }
    
    func fetchMoviesSimilar(id: Int, completion: @escaping (Result<MovieDbRes, Error>) -> Void) {
        APIClient.performRequest(route: APIRouter.similar(id: id)) { (result) in
            completion(result)
        }
    }
    
    
    @discardableResult
    public static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, Error>)->Void) -> DataRequest {
        return AF.request(route).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            
            switch response.response?.statusCode {
            case 200 : //This case will parse the T type.
                guard let data = response.data else {
                    completion(.failure(ApiError.noData))
                    return
                }
                
                do {
                    let decodedT = try decoder.decode(T.self, from: data)
                    completion(.success(decodedT))
                } catch {
                    completion(.failure(ApiError.parseError))
                }
            case 401,404: //This case will parse the MovieDbErr type
                guard let data = response.data else {
                    completion(.failure(ApiError.noData))
                    return
                }
                
                do {
                    let errorMessage = try decoder.decode(MovieDbErr.self, from: data)
                    completion(.failure(errorMessage))
                } catch {
                    completion(.failure(ApiError.parseError))
                }
            case 403:
                completion(.failure(ApiError.forbidden))
            case 409:
                completion(.failure(ApiError.conflict))
            case 500:
                completion(.failure(ApiError.internalServerError))
            default:
                completion(.failure(ApiError.unknownError))
            }
        }
    }
}

