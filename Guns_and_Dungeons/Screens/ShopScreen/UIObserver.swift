//
//  UIObserver.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потау on 05.12.2019.
//  Copyright © 2019 Александр Потау. All rights reserved.
//
import UIKit


class UIReviewer: UIImageView {
    
    let playerBody: UIImageView
    let playerGun: UIImageView
    let characteristics: UILabel
    
    init(params: UIReviewerPrams) {
        let playerSize: CGSize = CGSize(width: params.frame.width * 0.2, height: params.frame.width * 0.2)
        let playerFrame: CGRect = CGRect(centerPoint: CGPoint(x: params.frame.width / 2, y: params.frame.height * 0.25), size: playerSize)
        playerBody = UIImageView(frame: playerFrame)
        playerGun = UIImageView(frame: playerFrame)
        let labelSize: CGSize = CGSize(width: params.frame.width * 0.8, height: params.frame.height * 0.4)
        let labelFrame: CGRect = CGRect(centerPoint: CGPoint(x: params.frame.width / 2, y: params.frame.height * 0.75), size: labelSize)
        characteristics = UILabel(frame: labelFrame)
        characteristics.numberOfLines = 5
        characteristics.font = characteristics.font.withSize(characteristics.frame.width / 5)
        super.init(frame: params.frame)
        self.addSubview(playerBody)
        self.addSubview(playerGun)
        self.addSubview(characteristics)
        self.image = params.backImage
    }
    
    func setCharacteristics(pack: CharactPack) {
        var text: String = ""
        text += "Health: " + String(pack.hp) + "\n"
        text += "Speed: " + String(pack.speed) + "\n"
        text += "Damage: " + String(pack.damage) + "\n"
        text += "Armor: " + String(pack.armor) + "\n"
        characteristics.text = text
    }
    
    func updateState(pack: CharactPack, newBody: UIImage?) {
        setCharacteristics(pack: pack)
        playerBody.image = newBody
    }
    
    func updateState(pack: CharactPack, newGun: UIImage?) {
        setCharacteristics(pack: pack)
        playerGun.image = newGun
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct CharactPack {
    let speed: UInt64
    let armor: UInt64
    let hp:    Int64
    let damage: UInt64
    init(speed: UInt64, armor: UInt64, hp: Int64, damage: UInt64) {
        self.speed = speed
        self.armor = armor
        self.hp = hp
        self.damage = damage
    }
}

class UIReviewerPrams {
    let frame: CGRect
    let backImage: UIImage?
    init(frame: CGRect, backImage: UIImage?) {
        self.frame = frame
        self.backImage = backImage
    }
}
