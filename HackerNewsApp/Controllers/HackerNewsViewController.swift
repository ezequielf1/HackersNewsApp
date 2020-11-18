//
//  HackerNewsViewController.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import UIKit

final class HackerNewsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerNib(forType: HackerNewTableViewCell.self)
        }
    }
    
    // MARK: - Private Properties
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchHackerNews), for: .valueChanged)
        return refreshControl
    }()
    
    private var hackerNews: [HackerNew] = []
    
    // MARK: - Public Properties
    var viewModel: HackerNewsViewModel?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
}

// MARK: - Private Methods
private extension HackerNewsViewController {
    func start() {
        setupView()
        fetchHackerNews()
    }
    
    func setupView() {
        setupBinds()
        tableView.refreshControl = refreshControl
    }
    
    func setupBinds() {
        viewModel?.hackerNews.bind({ hackerNews in
            self.hackerNews = hackerNews
            self.updateView()
        })
    }
    
    func updateView() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc func fetchHackerNews() {
        viewModel?.fetchHackerNews()
    }
}

// MARK: - UITableViewDelegate
extension HackerNewsViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension HackerNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hackerNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(forType: HackerNewTableViewCell.self, atIndexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.model = hackerNews[indexPath.row]
        return cell
    }
}
