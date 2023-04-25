//
//  Movie.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import Foundation

struct Movie:Decodable{
    var id                  : Int
    var title               :String
    var synopsis            :String
    var release             :String
    var votes               :Int
    var votesAverage        :Float
    var imagePath           :String?
        
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case release = "release_date"
        case synopsis = "overview"
        case imagePath = "poster_path"
        case votes =  "vote_count"
        case votesAverage = "vote_average"
    }
}
