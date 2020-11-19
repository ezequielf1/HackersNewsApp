//
//  HackerNew.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import Foundation

struct HackerNew: Equatable {
    static func == (lhs: HackerNew, rhs: HackerNew) -> Bool {
        return lhs.title == rhs.title && lhs.author == rhs.author
    }
    
    let createdTimeAgo: String?
    let title: String
    let author: String?
    let storyUrl: String?
    
    init(from hackerNewDTO: HackerNewDTO) {
        title = hackerNewDTO.storyTitle ?? hackerNewDTO.title ?? "No title for this new"
        author = hackerNewDTO.author
        storyUrl = hackerNewDTO.storyUrl
        if let createdAt = hackerNewDTO.createdAt {
            createdTimeAgo = DateFormatter().format(dateString: createdAt, format: .full)?.timeAgoDisplay()
        } else {
            createdTimeAgo = ""
        }
    }
}
