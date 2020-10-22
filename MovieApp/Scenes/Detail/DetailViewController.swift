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
    private var movieDetail : MovieDetail?
    private var similarMovies : [MovieResult] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "SimilarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarCollectionViewCell")
        collectionView.layoutIfNeeded()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        presenter.detailViewDidLoad()
    }
    
    func setUI(){
        if let detail = self.movieDetail{
            movieTitle.text = detail.original_title
            movieDescription.text = detail.overview
            movieRate.text = "\(detail.vote_average)"
            movieDate.text = detail.release_date
            movieDescription.sizeToFit()
        }
    }
    
    @IBAction func imdbButton(_ sender: Any) {
        if let detail = self.movieDetail{
            if let imdbId = detail.imdb_id{
                presenter.showImdbPage(imdbId: imdbId)
            }else{
                self.showAlert(title: "Error", message: "There is no IMDB page", completionHandler: nil)
            }
        }else{
            self.showAlert(title: "Error", message: "There is no movie detail", completionHandler: nil)
        }
    }
}

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionViewCell", for: indexPath) as! SimilarCollectionViewCell
        if similarMovies.count > indexPath.row{
            if let path = similarMovies[indexPath.row].backdrop_path {
                cell.moviePoster.kf.setImage(with: URL(string: ProductionServer.posterUrl + path))
            }
            cell.movieTitle.text = similarMovies[indexPath.row].original_title
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.newMovieSelected(id: similarMovies[indexPath.row].id)
    }
}
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 105)
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
            self.movieDetail = detail
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
