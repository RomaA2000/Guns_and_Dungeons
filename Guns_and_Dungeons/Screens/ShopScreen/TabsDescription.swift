//
//  TabsDescription.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 13.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

class TabDescription {
    var cellInfos: [CellInfo] = []
    init(cellInfos: [CellInfo]) {
        self.cellInfos = cellInfos
    }
}

class CellInfo {
    let itemImage: UIImage
    let itemBackGround: UIImage
    let cost: Int
    let unlocked: Bool
    
    init(itemImage: UIImage, itemBackGround: UIImage ,unlocked: Bool, cost: Int) {
        self.itemImage = itemImage
        self.cost = cost
        self.unlocked = unlocked
    }
}



