//
//  HackerNews.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

struct HackerNews: Codable {
    let hits: [HackerNew]
}

struct HackerNew: Codable {
    let createdAt: String?
    let title: String?
    let author: String?
    let url: String?
    let storyTitle: String?
    let commentText: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title
        case author
        case url
        case storyTitle = "story_title"
        case commentText = "comment_text"
        
    }
}
