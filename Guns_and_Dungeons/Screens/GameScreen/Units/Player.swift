//
//  Player.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 15.11.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//
import Foundation
import SpriteKit

class Player: MobileUnit {
    init(params: PlayerParams) {
        super.init(params: params)
        name = "player"
        physicsBody = params.body
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = params.mask.category
        physicsBody?.collisionBitMask = params.mask.collision
        physicsBody?.contactTestBitMask = params.mask.contact
        runDefaultAnimation()
    }
    
    func moveByVector(direction: CGVector) {
        self.physicsBody?.velocity = CGVector(dx: self.maxSpeed * direction.dx, dy: self.maxSpeed * direction.dy)
    }
    
    func fire(currentTime: TimeInterval) {
        weapon?.fire(currentTime: currentTime)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PlayerParams : MobileUnitParams {
    let mask: PhysicsBodyMask
    let body : SKPhysicsBody;

    init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, body : SKPhysicsBody) {
        self.mask = mask
        self.body = body
        super.init(mobileUnitParams: mobileUnitParams)
    }
    
    convenience init(mobileUnitParams: MobileUnitParams, mask : PhysicsBodyMask, radius: CGFloat) {
        self.init(mobileUnitParams: mobileUnitParams, mask: mask, body: SKPhysicsBody(circleOfRadius: radius))
    }
}

