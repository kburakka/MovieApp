//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

public struct MovieDetail:Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case budget
        case genres
        case homepage
        case id
        case imdb_id
        case original_title
        case original_language
        case overview
        case popularity
        case poster_path
        case release_date
        case title
        case vote_count
        case video
        case vote_average
    }
    
    public let poster_path: String?
    public let adult: Bool
    public let overview: String
    public let release_date: String
    public let genres: [Genre]
    public let id: Int
    public let budget: Int
    public let original_title: String?
    public let imdb_id: String?
    public let homepage: String?
    public let original_language: String
    public let title: String
    public let backdrop_path: String?
    public let popularity: Double
    public let vote_count: Int
    public let video: Bool
    public let vote_average: Double
}
