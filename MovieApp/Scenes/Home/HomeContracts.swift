//
//  HomeContracts.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Interactor
protocol HomeInteractorProtocol: class {
    var delegate: HomeInteractorDelegate? { get set }
    func searchMovie(text : String)
    func upcomingMovies()
    func nowPlayingMovies()
}

enum HomeInteractorOutput {
    case setLoading(Bool)
    case searchMovie([MovieResult])
    case upcomingMovies([MovieResult])
    case nowPlayingMovies([MovieResult])
    case showError(Error)
}

protocol HomeInteractorDelegate: class {
    func handleOutput(_ output: HomeInteractorOutput)
}


// MARK: - Presenter
protocol HomePresenterProtocol: class {
    func selectMovie(id: Int, image: UIImage?)
    func searchMovie(text : String)
    func upcomingMovies()
    func nowPlayingMovies()
    func homeViewDidLoad()
}

enum HomePresenterOutput {
    case setLoading(Bool)
    case searchMovie([MovieResult])
    case upcomingMovies([MovieResult])
    case nowPlayingMovies([MovieResult])
    case showError(Error)
}


// MARK: - View
protocol HomeViewProtocol: class {
    func handleOutput(_ output: HomePresenterOutput)
}


// MARK: - Router
enum HomeRoute{
    case showDetail(UIImage?,Int)
}

protocol HomeRouterProtocol: class {
    func navigate(to route: HomeRoute)
}
