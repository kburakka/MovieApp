//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter : HomePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.nowPlayingMovies()
    }
}
extension HomeViewController : HomeViewProtocol{
    func handleOutput(_ output: HomePresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            print("to do")
        case .nowPlayingMovies(let movies):
            print(movies)
        case .searchMovie(_):
            print("to do")
        case .upcomingMovies(_):
            print("to do")
        case .showError(_):
            print("to do")
        }
    }
}
