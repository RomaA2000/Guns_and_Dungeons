//
//  Protocols.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import UIKit

protocol Callable: class {
    func call(number: Int)
}

protocol PanelSubview: UIView {
    init(frame: CGRect, num: Int)
}
