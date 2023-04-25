//
//  RealmMovieMapper.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import Foundation

class RealmMovieMapper{
    func map(movie:RealmMovie) -> Movie{
        return Movie(id: movie.id, title: movie.title, synopsis: movie.synopsis, release: movie.release, votes: movie.votes , votesAverage: movie.votesAverage, imagePath: movie.imageURL)
    }
}
