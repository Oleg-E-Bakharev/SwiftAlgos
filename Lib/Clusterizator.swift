//
//  Clusterizator.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.11.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public protocol Clusterizator {
    associatedtype Index: Equatable
    
    mutating func getCluster(_ index: Index) -> Index
    
    mutating func connect(_ a: Index,_ b: Index)

    mutating func isConnected(_ a: Index, _ b: Index) -> Bool
}

public extension Clusterizator {
    @inline(__always)
    mutating func isConnected(_ a: Index, _ b: Index) -> Bool {
        getCluster(a) == getCluster(b)
    }
}
