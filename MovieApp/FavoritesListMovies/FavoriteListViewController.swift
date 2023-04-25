//
//  FavoriteListViewController.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import UIKit

class FavoriteListViewController: DefaultListViewController {

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
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.presenter.onViewDidLoad()
    }
    
    private func configureTab(){
        self.title = "Favorites Movies"
        let customTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "favorites"), selectedImage: UIImage(named: "favorites"))
        customTabBarItem.title = "Favorites"
        self.tabBarItem = customTabBarItem
    }
    
    private func configureTableView(){
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieViewCell.self, forCellReuseIdentifier: "MovieViewCell")
        self.tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
    }
}

extension FavoriteListViewController: ListOfMoviesUIProtocol{
    func updateInterface(movies: [MovieViewCellModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavoriteListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = self.presenter.movies[indexPath.row]
        Task{
            let success = await presenter.addToFavorites(movie: movie)
            self.showDialogWith(message: success.1)
        }
    }
}

extension FavoriteListViewController: UITableViewDataSource{
    
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
