//
//  DetailBuilder.swift
//  MovieApp
//
//  Created by Burak KAYA on 22.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class DetailBuilder {
    static func make(with image: UIImage?, id: Int) -> DetailViewController {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let interactor = DetailInteractor(service: app.service)
        let presenter = DetailPresenter(view: view, image: image, id: id, interactor: interactor)
        view.presenter = presenter
        return view
    }
}
