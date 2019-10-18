//
//  FuncView.swift
//  Guns_and_Dungeons
//
//  Created by Роман Агеев on 18.10.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

func calcCenter(coord : CGPoint, frame : CGSize, size : CGSize) -> CGPoint {
    return CGPoint(x : coord.x * frame.width - 0.5 * size.width,
                   y: coord.y * frame.height - 0.5 * size.height)
}

extension UIView {
    func posSubviewByRect(subView : UIView, params : AllParameters) {
        let s : CGFloat = params.square * self.frame.width * self.frame.height
        let height : CGFloat = sqrt(CGFloat(s) / params.k)
        let width : CGFloat = params.k * height
        let size = CGSize(width: width, height: height)
        let center = calcCenter(coord: params.centerPoint, frame: self.frame.size, size: size)
        subView.frame = CGRect(origin: center, size: size)
        self.addSubview(subView)
    }
    
    func addButton(label : String, params : AllParameters) {
        let result = UIButton();
        result.setUpButton(label : label, color : .black, translatesMask: true)
        self.posSubviewByRect(subView: result, params: params)
    }
    
}
