//
//  HomeBuilder.swift
//  MovieApp
//
//  Created by Burak KAYA on 21.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class HomeBuilder {
    static func make() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let router = HomeRouter(view: view)
        let interactor = HomeInteractor(service: app.service)
        let presenter = HomePresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        return view
    }
}
