//
//  BinaryTreeInfo.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeInfo {
    associatedtype NodeRef: BinaryTreeNodeBase where NodeRef.NodeRef == NodeRef

    var root: NodeRef? { get }
    
    /// On
    func count() -> Int
    
    /// On
    func height() -> Int
    
    /// Maximum number of nodes in same distance from head
    /// On
    func width(stopAtDepth: Int) -> Int
    
    /// On
    func levelWidths(stopAtDepth: Int) -> [Int]
    
    /// On
    func diagram() -> String
}

public extension BinaryTreeInfo {
    func count() -> Int { count(of: root) }
    
    func height() -> Int { height(of: root) }
    
    func width(stopAtDepth: Int = .max) -> Int {
        var levelWidths: [Int] = []
        calculateWidth(of: root, level: 0, levelsWidth: &levelWidths, stopDepth: stopAtDepth)
        return levelWidths.max() ?? 0
    }
    
    func levelWidths(stopAtDepth: Int = .max) -> [Int] {
        var levelWidths: [Int] = []
        calculateWidth(of: root, level: 0, levelsWidth: &levelWidths, stopDepth: stopAtDepth)
        return levelWidths
    }
    
    func diagram() -> String {
        diagram(of: root)
    }
    
    private func count(of node: NodeRef?) -> Int {
        guard let node = node else { return 0 }
        return count(of: node.left) + 1 + count(of: node.right)
    }
    
    private func height(of node: NodeRef?) -> Int {
        guard let node = node else { return 0 }
        return max(height(of: node.left), height(of: node.right)) + 1
    }
    
    private func calculateWidth(of node: NodeRef?, level: Int, levelsWidth: inout [Int], stopDepth: Int = .max) {
        guard let node = node else { return }
        if level == levelsWidth.count {
            levelsWidth.append(0)
        }
        levelsWidth[level] += 1
        guard level < stopDepth else { return }
        calculateWidth(of: node.left, level: level + 1, levelsWidth: &levelsWidth, stopDepth: stopDepth)
        calculateWidth(of: node.right, level: level + 1, levelsWidth: &levelsWidth, stopDepth: stopDepth)
    }
    
    func diagram(of node: NodeRef?, top: String = "", root: String = "", bottom: String = "" ) -> String {
        guard let node = node else { return root + "nil\n" }
        
        if node.left == nil && node.right == nil {
            return root + "\(node)\n"
        }
        
        return diagram(of: node.right, top: top + "  ", root: top + "┌─", bottom: top + "│ ")
        + root + "\(node)\n"
        + diagram(of: node.left, top: bottom + "│ ", root: bottom + "└─", bottom: bottom + "  ")
    }
}
