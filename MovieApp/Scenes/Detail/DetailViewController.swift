//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Burak KAYA on 22.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol!
    private var detail : MovieDetail?
    private var poster = UIImageView()
    private var similarMovies : [MovieResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.detailViewDidLoad()
    }
    
    func setUI(){
        
    }
    
}

extension DetailViewController: DetailViewProtocol{
    func handleOutput(_ output: DetailPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading{
                LoadingView.init(view: view).startAnimation()
            }else{
                LoadingView.init(view: view).stopAnimation()
            }
        case .showDetail(let detail,let image):
            self.detail = detail
            if image != nil{
                self.poster.image = image
            }else{
                if let path = detail.backdrop_path {
                    self.poster.kf.setImage(with: URL(string: ProductionServer.posterUrl + path))
                }
            }
            setUI()
        case .showSimilarMovies(let movies):
            self.similarMovies = movies
        case .showError(let error):
            self.showAlert(title: "Error", message: error.localizedDescription, completionHandler: nil)
        }
    }
}
