//
//  Ask.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев. on 09.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.


import Foundation
import UIKit
import SpriteKit

class SpawnerRequest {
    var location : CGPoint
    init(location : CGPoint) {
        self.location = location
    }
}

class RequesSolver {
    let walls : [SKNode]
    init(walls : [SKNode]) {
        self.walls = walls
    }
    
    func solveOne(request : SpawnerRequest, players : [CGPoint]) -> CGPoint? {
        var first : Bool = true
        var ans : CGPoint? = nil
        var length : CGFloat = 0
        for i in players {
            var can = true
            for j in walls {
                if j.frame.intersect(p1: request.location, p2: i) {
                    can = false
                }
            }
            let nowLength = request.location.distance(to : i)
            if can && (first || length > nowLength) {
                first = false
                length = nowLength
                ans = i
            }
        }
        return ans
    }
    
    func solve(request : Array<SpawnerRequest>, players : [CGPoint]) -> Array<CGPoint?> {
        return Array<CGPoint?>(request.map({ solveOne(request: $0, players: players)}))
    }
}

