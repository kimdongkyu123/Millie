//
//  LocalDataSource.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation
import Combine

class LocalDataSource {
    
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService = DatabaseService()) {
        self.databaseService = databaseService
    }
    
    func fetchNews() -> AnyPublisher<News, Error> {
        return databaseService.fetchNews()
    }
    
    func saveNews(newsCache: NewsCache) -> AnyPublisher<Bool, Error> {
        return databaseService.saveNews(newsCache: newsCache)
    }
}
