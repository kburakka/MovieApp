//
//  Constants.swift
//  MovieApp
//
//  Created by Burak KAYA on 20.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire

struct ProductionServer {
    static let apiKey = "2aa4022c70415d52f076f0c5f22c9b7e"
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let posterUrl = "https://image.tmdb.org/t/p/w500"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
