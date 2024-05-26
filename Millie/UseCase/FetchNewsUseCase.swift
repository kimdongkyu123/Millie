//
//  FetchNewsUseCase.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation
import Combine

class FetchNewsUseCase {
    private let repository: NewsRepositoryProtocol

    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<News, Error> {
           return repository.fetchNews()
    }
}
