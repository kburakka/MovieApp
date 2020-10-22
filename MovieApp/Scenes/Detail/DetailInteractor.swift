//
//  DetailInteractor.swift
//  MovieApp
//
//  Created by Burak KAYA on 22.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import UIKit

final class DetailInteractor : DetailInteractorProtocol{
    var delegate: DetailInteractorDelegate?
    private var movieDetail: MovieDetail? = nil
    private let service: APIClientProtocol
    
    init(service: APIClientProtocol) {
        self.service = service
    }
    
    func showSimilarMovies(id: Int) {
        delegate?.handleOutput(.setLoading(true))
        service.fetchMoviesSimilar(id: id) { (result) in
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let movies):
                self.delegate?.handleOutput(.showSimilarMovies(movies.results))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        }
    }
    
    func showDetail(id: Int) {
        delegate?.handleOutput(.setLoading(true))
        service.fetchMovieDetail(id: id) { (result) in
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let detail):
                self.delegate?.handleOutput(.showDetail(detail))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        }
    }
}
