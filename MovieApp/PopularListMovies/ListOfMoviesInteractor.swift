//
//  ListOfMoviesInteractor.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import Foundation

protocol ListOfMoviesInteractorProtocol: AnyObject{
    func getMovies(movies: @escaping([Movie])-> ()) async
}
class ListOfMoviesInteractor: ListOfMoviesInteractorProtocol{
    func getMovies(movies: @escaping([Movie])-> ()) async{
        
        ApiClient.getMovies { data, error in
            guard let receivedData = data else{
                return
            }
            do {
                let movieResponseModel = try JSONDecoder().decode(MovieApiResponse.self, from: receivedData)
                movies(movieResponseModel.results)
            }catch _{
                return
            }
        }
    }
}
