//
//  ViewController.swift
//  GetMovie
//
//  Created by Bekzat Batyrkhanov on 20.10.2024.
//

import UIKit
import Alamofire
class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = MovieViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Trending Movies"
        setupTableView()
        setupBindings()
        viewModel.fetchTrendingMovies()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    private func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.getMovieTitle(at: indexPath.row))
        return cell
    }
}

