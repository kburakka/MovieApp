//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    var presenter : HomePresenterProtocol!

    var upcomingMovies : [MovieResult] = []{
        didSet{
            upcomingTableView.reloadData()
        }
    }

    var nowPlayingMovies : [MovieResult] = []{
        didSet{
            pageControl.numberOfPages = nowPlayingMovies.count
            pageControl.currentPage = 0
            collectionView.reloadData()
        }
    }
    
    var searchMovies : [MovieResult] = []{
        didSet{
            if searchTableView != nil && searchView != nil{
                searchTableView.reloadData()
                if searchMovies.count > 0{
                    searchView.isHidden = false
                }else{
                    searchView.isHidden = true
                }
            }
        }
    }
    
    var searchText = ""{
        didSet{
            if searchText.count > 2{
                presenter.searchMovie(text: searchText)
            }else{
                searchMovies = []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        presenter.homeViewDidLoad()
    }
    
    func registerNibs(){
        collectionView.register(UINib.init(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
        upcomingTableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: nil), forCellReuseIdentifier: "UpcomingTableViewCell")
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        if let path = nowPlayingMovies[indexPath.row].backdrop_path {
            cell.imageView.kf.setImage(with: URL(string: ProductionServer.posterUrl + path))
        }
        cell.title.text = nowPlayingMovies[indexPath.row].original_title
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SliderCollectionViewCell
        presenter.selectMovie(id: nowPlayingMovies[indexPath.row].id, image: cell?.imageView.image)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == upcomingTableView{
            return upcomingMovies.count
        }else if tableView == searchTableView{
            return searchMovies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == upcomingTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as! UpcomingTableViewCell
            if let path = nowPlayingMovies[indexPath.row].backdrop_path {
                cell.movieImageView.kf.setImage(with: URL(string: ProductionServer.posterUrl + path))
            }
            cell.title.text = nowPlayingMovies[indexPath.row].original_title
            cell.movieDescription.text = nowPlayingMovies[indexPath.row].overview
            return cell
        }else if tableView == searchTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
            cell.searchTitle.text = searchMovies[indexPath.row].original_title
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == upcomingTableView{
             return 86
         }else if tableView == searchTableView{
             return 44
         }
        return 86
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == upcomingTableView{
            let cell = tableView.cellForRow(at: indexPath) as? UpcomingTableViewCell
            presenter.selectMovie(id: upcomingMovies[indexPath.row].id, image: cell?.movieImageView.image)
         }else if tableView == searchTableView{
            presenter.selectMovie(id: searchMovies[indexPath.row].id, image: nil)
        }
    }
}

extension HomeViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension HomeViewController : HomeViewProtocol{
    func handleOutput(_ output: HomePresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading{
                LoadingView.init(view: view).startAnimation()
            }else{
                LoadingView.init(view: view).stopAnimation()
            }
        case .nowPlayingMovies(let movies):
            self.nowPlayingMovies = movies
        case .searchMovie(let movies):
            self.searchMovies = movies
        case .upcomingMovies(let movies):
            self.upcomingMovies = movies
        case .showError(let error):
            self.showAlert(title: "Hata", message: error.localizedDescription, completionHandler: nil)
        }
    }
}
