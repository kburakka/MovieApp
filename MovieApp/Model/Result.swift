//
//  Result.swift
//  MovieApp
//
//  Created by Burak KAYA on 20.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

public struct Result:Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case poster_path
        case adult
        case overview
        case release_date
        case genre_ids
        case id
        case original_title
        case original_language
        case title
        case backdrop_path
        case popularity
        case vote_count
        case video
        case vote_average
    }
    
    public let poster_path: String?
    public let adult: Bool
    public let overview: String
    public let release_date: String
    public let genre_ids: [Int]
    public let id: Int
    public let original_title: String?
    public let original_language: String
    public let title: String
    public let backdrop_path: String?
    public let popularity: Double
    public let vote_count: Int
    public let video: Bool
    public let vote_average: Double
}
