//
//  DatabaseService.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation
import Combine
import RealmSwift

class DatabaseService {
    
    let realm = try! Realm()
    
    func fetchNews() -> AnyPublisher<News, Error> {
        let path = realm.configuration.fileURL?.deletingLastPathComponent().path
        print("RealmPath : \(String(describing: path))")
        return Just(()).map { _ -> NewsCache? in
            return realm.objects(NewsCache.self).first
        }
        .map { cache -> News? in
            if let cache = cache {
                let decoder = JSONDecoder()
                if let jsonData = cache.jsonString.data(using: .utf8) {
                    return try? decoder.decode(News.self, from: jsonData)
                }
            }
            return nil
        }
        .compactMap {
            return $0
        }
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    func saveNews(newsCache: NewsCache) -> AnyPublisher<Bool, Error> {
        let path = realm.configuration.fileURL?.deletingLastPathComponent().path
        print("RealmPath : \(String(describing: path))")
        return Future<Bool, Error> { [weak self] promise in
            if let self = self {
                try? self.realm.write {
                    self.realm.add(newsCache, update: .modified)
                    promise(.success(true))
                }
            } else {
                promise(.failure(Realm.Error.callFailed))
            }
        }
        .eraseToAnyPublisher()
    }
}
