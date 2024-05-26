//
//  RemoteDataSource.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation
import Combine

class RemoteDataSource {
    
    private let apiService : ApiService
    
    init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }
    
    func fetchNews() -> AnyPublisher<News, Error> {
        return apiService.fetchNews()
    }
}
