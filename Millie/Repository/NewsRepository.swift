//
//  NewsRepository.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {
    func fetchNews() -> AnyPublisher<News, Error>
}

class NewsRepository : NewsRepositoryProtocol {
    
    private let localDataSource: LocalDataSource
    private let remoteDataSource: RemoteDataSource
    
    private var cancellables = Set<AnyCancellable>()
    
    init(localDataSource: LocalDataSource = LocalDataSource(),
         remoteDataSource: RemoteDataSource = RemoteDataSource()) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchNews() -> AnyPublisher<News, Error> {
        let localPublisher = localDataSource.fetchNews()
        return remoteDataSource.fetchNews()
            .map { [weak self] news in
                self?.saveNews(news: news)
                return news
            }
            .catch { error in
                return localPublisher
            }
            .eraseToAnyPublisher()
    }
    
    private func saveNews(news: News?) {
        let jsonEncoder = JSONEncoder()
        guard let news = news,
              let jsonData = try? jsonEncoder.encode(news),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return
        }

        let cache = NewsCache(jsonString: jsonString)
        localDataSource.saveNews(newsCache: cache)
            .sink { completion in
                switch completion {
                case .finished:
                    print("repository saveNews: finished")
                case .failure(let error):
                    print("repository saveNews: failure: \(error.localizedDescription)")
                }
            } receiveValue: { success in
                print("repository saveNews: \(success)")
            }
            .store(in: &cancellables)
    }
}
