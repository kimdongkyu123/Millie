//
//  NavigationProtocol.swift
//  Millie
//
//  Created by DK on 5/23/24.
//

import Foundation

protocol NavigationRoutable {
    var destinations: [NavigationDestination] { get }
    func push(to view: NavigationDestination)
    func pop()
}
