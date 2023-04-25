//
//  SearchListRouter.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import Foundation
import UIKit

class SearchListRouter{
    func configureSearchView(navigationItem:UINavigationItem){
        let interactor = SearchMoviesInteractor()
        let dbInteractor = ListOfMoviesDBInteractor()
        let presenter = SearchListMoviesPresenter(searchInteractor: interactor,dbInteractor: dbInteractor)
        let searchList = SearchListMoviesViewController(presenter: presenter)
        presenter.viewDelegate = searchList
        
        let searchController = UISearchController(searchResultsController: searchList)
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = searchList
    }
}
