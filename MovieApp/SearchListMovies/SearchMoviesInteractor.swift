//
//  SearchMoviesInteractor.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 21/4/23.
//

import Foundation

protocol SearchMoviesInteractorProtocol: AnyObject{
    func getMoviesWithSearch(query:String, movies: @escaping([Movie])-> ())
}

class SearchMoviesInteractor: SearchMoviesInteractorProtocol{
    func getMoviesWithSearch(query:String, movies: @escaping([Movie])-> ()){
        ApiClient.searchMovies(query: query) { data, error in
            guard let receivedData = data else{
                return
            }
            do {
                let movieResponseModel = try JSONDecoder().decode(MovieApiResponse.self, from: receivedData)
                movies(movieResponseModel.results)
            }catch let error{
                print(error)
                return
            }
        }
    }
}
