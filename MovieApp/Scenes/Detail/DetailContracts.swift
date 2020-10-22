//
//  DetailContracts.swift
//  MovieApp
//
//  Created by Burak KAYA on 22.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Interactor
protocol DetailInteractorProtocol: class {
    var delegate: DetailInteractorDelegate? { get set }
    func showDetail(id: Int)
    func showSimilarMovies(id: Int)
}

enum DetailInteractorOutput {
    case setLoading(Bool)
    case showDetail(MovieDetail)
    case showSimilarMovies([MovieResult])
    case showError(Error)
}

protocol DetailInteractorDelegate: class {
    func handleOutput(_ output: DetailInteractorOutput)
}


// MARK: - Presenter
protocol DetailPresenterProtocol: class {
    func showDetail(id: Int)
    func showSimilarMovies(id: Int)
    func detailViewDidLoad()
}

enum DetailPresenterOutput {
    case setLoading(Bool)
    case showDetail(MovieDetail,UIImage?)
    case showSimilarMovies([MovieResult])
    case showError(Error)
}


// MARK: - View
protocol DetailViewProtocol: class {
    func handleOutput(_ output: DetailPresenterOutput)
}


// MARK: - Router
enum DetailRoute{
    case showHomepage
}

protocol DetailRouterProtocol: class {
    func navigate(to route: DetailRoute)
}
