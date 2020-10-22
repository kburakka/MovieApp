//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class HomePresenter:HomePresenterProtocol{
    private unowned let view: HomeViewProtocol
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol

    init(view: HomeViewProtocol,
          interactor: HomeInteractorProtocol,
          router: HomeRouterProtocol) {
         self.view = view
         self.interactor = interactor
         self.router = router
         
         self.interactor.delegate = self
    }
        
    func selectMovie(id: Int, image: UIImage?) {
        router.navigate(to: .showDetail(image, id))
    }
    
    func homeViewDidLoad() {
        upcomingMovies()
        nowPlayingMovies()
    }
    

    func searchMovie(text: String) {
        interactor.searchMovie(text: text)
    }
    
    func upcomingMovies() {
        interactor.upcomingMovies()
    }
    
    func nowPlayingMovies() {
        interactor.nowPlayingMovies()
    }
}

extension HomePresenter: HomeInteractorDelegate{
    func handleOutput(_ output: HomeInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .searchMovie(let movies):
            view.handleOutput(.searchMovie(movies))
        case .upcomingMovies(let movies):
            view.handleOutput(.upcomingMovies(movies))
        case .nowPlayingMovies(let movies):
            view.handleOutput(.nowPlayingMovies(movies))
        case .showError(let error):
            view.handleOutput(.showError(error))
        }
    }
}
