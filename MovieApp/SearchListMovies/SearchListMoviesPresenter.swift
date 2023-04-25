//
//  SearchListMoviesPresenter.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 21/4/23.
//

import Foundation

protocol SearchListMoviesPresenterProtocol:AnyObject{
    func search(query:String)
    var viewDelegate :SearchListMoviesUIProtocol? { get }
    var movies : [MovieViewCellModel] { get }
    func addToFavorites(movie:MovieViewCellModel) async -> (Bool, String)
}

protocol SearchListMoviesUIProtocol:AnyObject{
    func updateInterface(movies:[MovieViewCellModel])
}

class SearchListMoviesPresenter:SearchListMoviesPresenterProtocol{
    private let interactor : SearchMoviesInteractorProtocol
    private let dbInteractor : ListOfMoviesDBInteractorProtocol
    
    weak var viewDelegate: SearchListMoviesUIProtocol?
    var movies : [MovieViewCellModel] = []
    private let moviesMapper = MovieViewCellMapper()
    
    init(searchInteractor:SearchMoviesInteractorProtocol, dbInteractor:ListOfMoviesDBInteractorProtocol){
        self.interactor = searchInteractor
        self.dbInteractor = dbInteractor
    }
    
    func search(query:String){
        self.interactor.getMoviesWithSearch(query: query) { moviesResponse in
            self.movies = moviesResponse.map(self.moviesMapper.map(movie:))
            self.viewDelegate?.updateInterface(movies: self.movies)
        }
    }
    
    func addToFavorites(movie: MovieViewCellModel) async -> (Bool, String){
        let saved = await dbInteractor.saveMovie(movie: movie)
        let message :String = saved == true ? "Added to favorites" : "Deleted from favorites"
        return (saved, message)
    }
}
