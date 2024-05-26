//
//  NewsViewModel.swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    
    @Published var news: News?
    
    private let fetchNewsUseCase: FetchNewsUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    var visitedList = Set<String>()
    
    init(fetchNewsUseCase: FetchNewsUseCase = FetchNewsUseCase()) {
        self.fetchNewsUseCase = fetchNewsUseCase
    }
    
    func execute() {
        fetchNewsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    break
                case .failure( _):
                    break
                }
            }, receiveValue: { [weak self] news in
                self?.news = news
            }).store(in: &cancellables)
    }
}

