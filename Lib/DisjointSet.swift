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
    
    public private(set) var numberOfClusters: Int = 0
    
    public init(count: Int) {
        reserveCapacity(capacity: count)
    }
    
    public mutating func reserveCapacity(capacity: Int) {
        guard capacity > roots.count else { return }
        roots.append(contentsOf: (roots.count..<capacity).map { $0 })
        ranks.append(contentsOf: (ranks.count..<capacity).map {_ in 0 })
        numberOfClusters += capacity - numberOfClusters
    }
}

extension DisjointSet : Clusterizator {
    
    /// O1 avg.
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
    
    /// O1 avg.
    public mutating func connect(_ a: Int, _ b: Int) {
        let rootA = getCluster(a)
        let rootB = getCluster(b)
        
        guard rootA != rootB else { return }
        
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
        numberOfClusters -= 1
    }
}

extension DisjointSet: Sequence {
    public struct Iterator : IteratorProtocol {
        var clusters: [[Int]]
        var current: Int = 0
        
        public init(disjointSet: DisjointSet) {
            clusters = .init(repeating: [], count: disjointSet.numberOfClusters)
            var rootMap: [Int : Int] = [:] // root index to clusterNumber
            for (i, root) in disjointSet.roots.enumerated() {
                let cluster = rootMap[root] ?? rootMap.count
                if cluster == rootMap.count {
                    rootMap[root] = cluster
                }
                clusters[cluster].append(i)
            }
        }
        
        public mutating  func next() -> [Int]? {
            guard current < clusters.count else { return nil }
            defer  { current += 1 }
            return clusters[current]
        }
    }
    
    public func makeIterator() -> Iterator {
        return Iterator(disjointSet: self)
    }
}

extension DisjointSet: CustomStringConvertible {
    public var description: String {
        var result = "\(Self.self)\n"
        for cluster in self {
            result += "\(cluster)\n"
        }
        return result
    }
}
