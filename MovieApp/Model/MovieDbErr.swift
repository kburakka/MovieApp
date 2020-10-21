//
//  MovieDbErr.swift
//  MovieApp
//
//  Created by Burak KAYA on 20.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Alamofire

public struct MovieDbErr:Decodable, Equatable,Error {
    
    public enum CodingKeys: String, CodingKey {
        case status_message
        case status_code
    }
    
    public let status_message: String
    public let status_code: Int
}
