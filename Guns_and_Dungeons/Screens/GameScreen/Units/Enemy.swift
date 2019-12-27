//
//  ContactEnemy.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//
import SpriteKit

class Enemy : MobileUnit {
    var purviewRange: Int = 0
    var dist : CGFloat = 100
    init(params: EnemyParams) {
        purviewRange = params.purviewRange
        dist = params.dist
        super.init(params: params)
        name = "enemy"
        physicsBody = params.body
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = params.mask.category
        physicsBody?.collisionBitMask = params.mask.collision
        physicsBody?.contactTestBitMask = params.mask.contact
        runDefaultAnimation()
    }
    
    override func update(_ currentTime: TimeInterval, target: CGPoint?) {
           if let point = target {
               let vector = getVector(to: point)
               let l = vector.length()
               zRotation = vector.getAngle(v: CGVector(dx: 0, dy: 1))
               if (point.distance(to: position) > 60) {
                   physicsBody?.velocity = CGVector(dx: vector.dx / l * maxSpeed , dy: vector.dy / l * maxSpeed)
               } else {
                   physicsBody?.velocity = CGVector(dx: 0 , dy: 0)
               }
           }
        super.update(currentTime, target: target)
       }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class EnemyParams : MobileUnitParams {
    var purviewRange: Int;
    let mask: PhysicsBodyMask
    let body : SKPhysicsBody;
    let dist : CGFloat
    
    init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, body : SKPhysicsBody, purviewRange: Int, dist: CGFloat) {
        self.mask = mask
        self.purviewRange = purviewRange
        self.body = body
        self.dist = dist
        super.init(mobileUnitParams: mobileUnitParams)
    }
    
    convenience init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, radius: CGFloat, purviewRange: Int, dist: CGFloat) {
        self.init(mobileUnitParams: mobileUnitParams, mask: mask, body: SKPhysicsBody(circleOfRadius: radius), purviewRange: purviewRange, dist: dist)
    }
    
}
