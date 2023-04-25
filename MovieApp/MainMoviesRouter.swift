//
//  MainMoviesRouter.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import Foundation
import UIKit
class MainMoviesRouter{
    func configureMainView(window:UIWindow?){
       
        let interactor = ListOfMoviesInteractor()
        let dbInteractor = ListOfMoviesDBInteractor()
        let presenter = ListOfMoviesPresenter(listInteractor: interactor, dbInteractor: dbInteractor)
        let moviesVController = ListOfMoviesViewController(presenter: presenter)
        presenter.viewDelegate = moviesVController
        let moviesNav = UINavigationController(rootViewController: moviesVController)
        
        
        let favInteractor = FavoriteListInteractor()
        let favdbInteractor = ListOfMoviesDBInteractor()
        let favPresenter = FavoriteListPresenter(listInteractor: favInteractor, dbInteractor: favdbInteractor)
        let favoritesVController = FavoriteListViewController(presenter: favPresenter)
        favPresenter.viewDelegate = favoritesVController
        let favNav = UINavigationController(rootViewController: favoritesVController)
      
        let rootTabBar = UITabBarController()
        
        rootTabBar.viewControllers = [moviesNav, favNav]
        
        window?.rootViewController = rootTabBar
        window?.makeKeyAndVisible()
    }
}

