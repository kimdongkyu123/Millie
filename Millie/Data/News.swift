//
//  News.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation

struct News : Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    private enum CodingKeys: String, CodingKey {
        case status, totalResults, articles
    }
}

struct Article: Codable, Identifiable {
    var id = UUID()
    let source: Source?
    let author: String?
    let title: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case source, author, title, url, urlToImage, publishedAt, content, description
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
