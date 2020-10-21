//
//  APIRouter.swift
//  MovieApp
//
//  Created by Burak KAYA on 20.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case now_playing
    case upcoming
    case search(searchText : String)
    case detail(id : Int)
    case similar(id : Int)

    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .now_playing:
            return .get
        case .upcoming:
            return .get
        case .search:
            return .get
        case .detail:
            return .get
        case .similar:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .now_playing:
            return "movie/now_playing?"
        case .upcoming:
            return "movie/upcoming?"
        case .search(let searchText):
            return "search/movie?query=\(searchText)&"
        case .detail(let id):
            return "movie/\(id)?"
        case .similar(id: let id):
            return "movie/\(id)/similar?"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = ProductionServer.baseUrl + path + "api_key=" + ProductionServer.apiKey
        print(urlString)
        let url = try urlString.asURL()
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        return urlRequest
    }
}
