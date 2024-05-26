//
//  APIService..swift
//  Millie
//
//  Created by DK on 5/21/24.
//

import Foundation
import Alamofire
import Combine

class ApiService {
    
    func fetchNews() -> AnyPublisher<News, Error> {
        let url = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=0f91934f1ec645b3bdc9afc3945ce587"
        return AF.request(url)
            .validate()
            .publishDecodable(type: News.self)
            .value()
            .mapError { error -> Error in
                return error as Error
            }
            .eraseToAnyPublisher()
    }
}
