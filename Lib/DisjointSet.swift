//
//  DisjointSet.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.11.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct DisjointSet {
    var roots: [Int] = []
    var ranks: [Int] = []
    
    public init(count: Int) {
        roots = (0..<count).map { $0 }
        ranks = (0..<count).map { _ in 0 }
    }
    
    public mutating func reserveCapacity(capacity: Int) {
        guard capacity > roots.count else { return }
        roots.append(contentsOf: (ranks.count..<capacity).map { $0 })
        ranks.append(contentsOf: (ranks.count..<capacity).map {_ in 0 })
    }
}

extension DisjointSet : Clusterizator {
    
    public mutating func getCluster(_ x:Int) -> Int {
        var root = x
        while roots[root] != root {
            root = roots[root]
        }
        var prev = x
        while roots[prev] != prev {
            prev = roots[prev]
            roots[prev] = root
        }
        roots[x] = root
        return root
    }
    
    public mutating func connect(_ a: Int, _ b: Int) {
        let rootA = getCluster(a)
        let rootB = getCluster(b)
        let rankA = ranks[rootA]
        let rankB = ranks[rootB]
        if rankA < rankB {
            roots[rootA] = rootB
        } else {
            roots[rootB] = rootA
            if rankA == rankB {
                ranks[rootA] += 1
            }
        }
    }
}
