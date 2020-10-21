//
//  Genre.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

public struct Genre:Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public let id: Int
    public let name: String
}
