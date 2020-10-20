//
//  MovieDbRes.swift
//  MovieApp
//
//  Created by Burak KAYA on 20.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

public struct MovieDbRes:Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case page
        case results
        case total_results
        case total_pages
    }
    
    public let page: Int
    public let results: [Result]
    public let total_results: Int
    public let total_pages: Int
}
