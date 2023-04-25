//
//  FavoriteListPresenter.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import Foundation

class FavoriteListPresenter:ListOfMoviesPresenter{
    override func addToFavorites(movie:MovieViewCellModel) async -> (Bool, String) {
        let success = await super.addToFavorites(movie: movie)
        self.onViewDidLoad()
        return success
    }
}
