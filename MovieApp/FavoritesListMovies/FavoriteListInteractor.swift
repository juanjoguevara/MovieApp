//
//  FavoriteListInteractor.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import Foundation
import Realm
import RealmSwift

class FavoriteListInteractor:ListOfMoviesInteractorProtocol{

    func getMovies(movies: @escaping ([Movie]) -> ()) async {
        let realm = try! await Realm()
        let objects = realm.objects(RealmMovie.self)
        let mapper = RealmMovieMapper()
        var moviesModel : [Movie] = []
        moviesModel = objects.map(mapper.map(movie:))

        movies(moviesModel)
    }
}
