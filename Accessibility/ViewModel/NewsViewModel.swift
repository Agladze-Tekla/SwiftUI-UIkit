//
//  NewsViewModel.swift
//  Accessibility
//
//  Created by Tekla on 12/27/23.
//

import Foundation
import NewsPackage

final class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
    init() {
        fetchNews()
    }
    
    func fetchNews() {
        let apiKey = "3e022d4db9084211a461897ae5687409"
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-12-26&to=2023-12-26&sortBy=popularity&apiKey=\(apiKey)"
        guard let URL = URL(string: urlString) else { return }
        
        NetworkManager.shared.fetchDecodableData(from: URL, responseType: Result.self, completion: { result in
            switch result {
            case .success(let data):
                self.articles = data.articles
            case .failure(let error):
                print("Error")
            }
        })
    }
}
