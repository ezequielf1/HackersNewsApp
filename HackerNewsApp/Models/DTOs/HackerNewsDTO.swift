//
//  HackerNewsDTO.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

struct HackerNewsDTO: Codable {
    let hits: [HackerNewDTO]
}

struct HackerNewDTO: Codable, Equatable {
    let createdAt: String?
    let title: String?
    let author: String?
    let storyUrl: String?
    let storyTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title
        case author
        case storyUrl = "story_url"
        case storyTitle = "story_title"
    }
}

