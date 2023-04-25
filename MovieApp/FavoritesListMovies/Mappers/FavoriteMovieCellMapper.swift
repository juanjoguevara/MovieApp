//
//  FavoriteMovieCellMapper.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import Foundation
import Realm
import RealmSwift

class FavoriteMovieCellMapper{
    func map(movie:Movie) -> MovieViewCellModel{
        let path = movie.imagePath ?? ""
        let imageURL = URL(string: path)
        return MovieViewCellModel(id: movie.id, title: movie.title, synopsis: movie.synopsis, imageURL: imageURL, release:movie.release, votes: String(movie.votes), votesAverage: String(round(movie.votesAverage)))
    }
}

