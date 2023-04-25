//
//  SearchListMoviesViewController.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import UIKit

class SearchListMoviesViewController: DefaultListViewController {
    private let presenter: SearchListMoviesPresenterProtocol
    
    @IBOutlet weak var tableView: UITableView!
    init(presenter:SearchListMoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        // Do any additional setup after loading the view.
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


extension SearchListMoviesViewController: UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = self.presenter.movies[indexPath.row]
        Task{
            let success = await presenter.addToFavorites(movie: movie)
            self.showDialogWith(message: success.1)
        }
    }
}

extension SearchListMoviesViewController: UITableViewDataSource{
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

extension SearchListMoviesViewController: SearchListMoviesUIProtocol{
    func updateInterface(movies: [MovieViewCellModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension SearchListMoviesViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else{
            return
        }
        presenter.search(query: query)
    }
}
