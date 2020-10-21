//
//  ApiError.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case forbidden              //Status code 403
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case noData
    case parseError
    case unknownError
}
