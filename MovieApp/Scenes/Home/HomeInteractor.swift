//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import UIKit

final class HomeInteractor : HomeInteractorProtocol{

    var delegate: HomeInteractorDelegate?
    private var movies: [MovieResult] = []
    private let service: APIClientProtocol
    
    init(service: APIClientProtocol) {
        self.service = service
    }

    func searchMovie(text: String) {
        delegate?.handleOutput(.setLoading(true))
        service.fetchMoviesSearch(searchText: text, completion: { (result) in
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let movies):
                self.movies = movies.results
                self.delegate?.handleOutput(.searchMovie(self.movies))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        })
    }
    
    func upcomingMovies() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchMoviesUpcoming(completion: { (result) in
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let movies):
                self.movies = movies.results
                self.delegate?.handleOutput(.upcomingMovies(self.movies))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        })
    }
    
    func nowPlayingMovies() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchMoviesNowPlaying(completion: { (result) in
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let movies):
                self.movies = movies.results
                self.delegate?.handleOutput(.nowPlayingMovies(self.movies))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        })
    }
}
