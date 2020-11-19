//
//  HackerNewTableViewCell.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import UIKit

final class HackerNewTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var extraDataLabel: UILabel!
    
    // MARK: - Public Properties
    var model: HackerNew? {
        didSet {
            titleLabel.text = model?.title
            if let author = model?.author {
                extraDataLabel.text = author + " - " + (model?.createdTimeAgo ?? "")
            }
        }
    }
}
