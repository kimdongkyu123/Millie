//
//  NavigationRouter.swift
//  Millie
//
//  Created by DK on 5/23/24.
//

import Foundation

class NavigationRouter: NavigationRoutable, ObservableObject {
    
    var destinations: [NavigationDestination] = []
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
        objectWillChange.send()
    }
    
    func pop() {
        _ = destinations.popLast()
        objectWillChange.send()
    }

}
