//
//  ListOfMoviesPresenter.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import Foundation

protocol ListOfMoviesPresenterProtocol: AnyObject{
    func onViewDidLoad()
    var  viewDelegate :ListOfMoviesUIProtocol? { get }
    var  movies : [MovieViewCellModel] { get }
    func addToFavorites(movie:MovieViewCellModel) async -> (Bool, String)
}

protocol ListOfMoviesUIProtocol: AnyObject{
    func updateInterface(movies:[MovieViewCellModel])
}

class ListOfMoviesPresenter: ListOfMoviesPresenterProtocol {

    private let interactor : ListOfMoviesInteractorProtocol
    private let dbInteractor :ListOfMoviesDBInteractorProtocol
    private let moviesMapper = MovieViewCellMapper()
    
    weak var viewDelegate: ListOfMoviesUIProtocol?
    var movies : [MovieViewCellModel] = []

    init(listInteractor:ListOfMoviesInteractorProtocol, dbInteractor:ListOfMoviesDBInteractorProtocol){
        self.interactor = listInteractor
        self.dbInteractor = dbInteractor
    }
    
    func onViewDidLoad(){
        Task{
            await self.interactor.getMovies { moviesResponse in
                self.movies = moviesResponse.map(self.moviesMapper.map(movie:))
                self.viewDelegate?.updateInterface(movies: self.movies)
            }
        }
    }
    
    func addToFavorites(movie: MovieViewCellModel) async -> (Bool, String){
        let saved = await dbInteractor.saveMovie(movie: movie)
        let message :String = saved == true ? "Added to favorites" : "Deleted from favorites"
        return (saved, message)
    }
}
