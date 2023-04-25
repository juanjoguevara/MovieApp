//
//  ListOfMoviesDBInteractor.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import Foundation
import Realm
import RealmSwift

protocol ListOfMoviesDBInteractorProtocol:AnyObject{
    func saveMovie(movie:MovieViewCellModel) async -> (Bool)
}

class ListOfMoviesDBInteractor:ListOfMoviesDBInteractorProtocol{
    
    func saveMovie(movie:MovieViewCellModel) async -> Bool{
        let realm = try! await Realm()
        
        if let object = realm.object(ofType: RealmMovie.self, forPrimaryKey: movie.id) {
            try! realm.write {
                realm.delete(object)
            }
            return false
        }
        
        let movieRM = RealmMovie()
        movieRM.id = movie.id
        movieRM.title = movie.title
        movieRM.synopsis = movie.synopsis
        movieRM.imageURL = movie.imageURL?.absoluteString ?? ""
        movieRM.release = movie.release
        movieRM.votes = Int(movie.votes) ?? 0
        movieRM.votesAverage = Float(movie.votesAverage) ?? 0.0
        
        try! realm.write {
            realm.add(movieRM, update: .all)
        }
        return true
    }
}
