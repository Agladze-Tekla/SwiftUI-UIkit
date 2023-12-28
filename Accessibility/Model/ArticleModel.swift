//
//  ArticleModel.swift
//  Accessibility
//
//  Created by Tekla on 12/27/23.
//

import Foundation

// MARK: - Result
struct Result: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Decodable {
    let author: String?
    let title, description: String
    let publishedAt: Date
    let content: String
}

