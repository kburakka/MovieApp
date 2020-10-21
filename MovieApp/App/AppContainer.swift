//
//  AppContainer.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let service = APIClient()
}
