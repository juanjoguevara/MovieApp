//
//  ListOfMoviesViewController.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import UIKit

class ListOfMoviesViewController: DefaultListViewController {

    @IBOutlet weak var tableView: UITableView!
    private let presenter: ListOfMoviesPresenterProtocol
    
    init(presenter:ListOfMoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.configureTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBarView()
        self.configureTableView()
        presenter.onViewDidLoad()
    }
    
    private func configureTableView(){
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieViewCell.self, forCellReuseIdentifier: "MovieViewCell")
        self.tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
    }
    
    private func configureSearchBarView(){
        let router = SearchListRouter()
        router.configureSearchView(navigationItem: self.navigationItem)
    }
    
    private func configureTab(){
        self.title = "Popular Movies"
        let customTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "movie-reel"), selectedImage: UIImage(named: "movie-reel"))
        customTabBarItem.title = "Popular"
        self.tabBarItem = customTabBarItem
    }
}

extension ListOfMoviesViewController: ListOfMoviesUIProtocol{
    func updateInterface(movies: [MovieViewCellModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListOfMoviesViewController: UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = self.presenter.movies[indexPath.row]
            Task{
                let success = await presenter.addToFavorites(movie: movie)
                self.showDialogWith(message: success.1)
            }
    }
}

extension ListOfMoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        let movie = self.presenter.movies[indexPath.row]
        cell.configureView(movie: movie)
        
        return cell
    }
    
    
}
