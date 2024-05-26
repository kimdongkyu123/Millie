//
//  NewsCache.swift
//  Millie
//
//  Created by DK on 5/22/24.
//

import Foundation
import RealmSwift

class NewsCache : Object {
    
    @Persisted(primaryKey: true)
    var id: Int = 0
    
    @Persisted
    var jsonString : String
    
    
    override init() {
        super.init()
    }
    
    init(jsonString: String) {
        self.jsonString = jsonString
    }
    
}
