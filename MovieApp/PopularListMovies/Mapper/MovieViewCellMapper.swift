//
//  MovieViewCellMapper.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 21/4/23.
//

import Foundation

struct MovieViewCellMapper{
    func map(movie:Movie) -> MovieViewCellModel{
        let path = movie.imagePath ?? ""
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w200" + path)
        let date = MovieViewCellMapper.releaseDate(string: movie.release)
        return MovieViewCellModel(id: movie.id, title: movie.title, synopsis: movie.synopsis, imageURL: imageURL, release:date, votes: String(movie.votes), votesAverage: String(round(movie.votesAverage)))
    }
    
    static func releaseDate(string: String) -> String{
        let formatter = DateFormatter()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:string) else{
            return ""
        }
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        let string = formatter.string(from: date)
        return string
    }
}
