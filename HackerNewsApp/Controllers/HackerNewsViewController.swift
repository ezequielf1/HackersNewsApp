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
    
    var viewModel: HackerNewsViewModel? = .init(service: HackerNewsService())
    
    private var hackerNews: [HackerNew] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchHackerNews()
        setupBinds()
    }
}

// MARK: - Private Methods
private extension HackerNewsViewController {
    func setupBinds() {
        viewModel?.hackerNews.bind({ hackerNews in
            self.hackerNews = hackerNews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
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
