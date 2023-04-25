//
//  MovieApiResponse.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import Foundation

class MovieApiResponse: Decodable{
    var results : [Movie]
    var page    : Int?
}
