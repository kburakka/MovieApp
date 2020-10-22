//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Burak KAYA on 22.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class DetailPresenter: DetailPresenterProtocol {

    unowned var view: DetailViewProtocol
    private let id: Int
    private var image: UIImage?
    private let interactor: DetailInteractorProtocol

    init(view: DetailViewProtocol, image: UIImage?, id: Int, interactor : DetailInteractorProtocol) {
        self.view = view
        self.id = id
        self.image = image
        self.interactor = interactor
        
        interactor.delegate = self
    }
    
    func showDetail(id: Int) {
        interactor.showDetail(id: id)
    }
    
    func showSimilarMovies(id: Int) {
        interactor.showSimilarMovies(id: id)
    }
    
    func newMovieSelected(id: Int) {
        showDetail(id: id)
        showSimilarMovies(id: id)
    }
    
    func detailViewDidLoad() {
        showDetail(id: id)
        showSimilarMovies(id: id)
    }
    
    func showImdbPage(imdbId: String) {
        let imdbBaseUrl = "https://www.imdb.com/title/"
        if let url = URL(string: imdbBaseUrl + imdbId) {
            UIApplication.shared.open(url)
        }
    }
}

extension DetailPresenter: DetailInteractorDelegate{
    func handleOutput(_ output: DetailInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showDetail(let detail):
            view.handleOutput(.showDetail(detail, image))
            image = nil
        case .showSimilarMovies(let movies):
            view.handleOutput(.showSimilarMovies(movies))
        case .showError(let error):
            view.handleOutput(.showError(error))
        }
    }
}
