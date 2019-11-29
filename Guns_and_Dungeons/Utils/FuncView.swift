//
// FuncView.swift
// Guns_and_Dungeons
//
//  Created by Роман Геев on 18.10.2019.
//  Copyright © 2019 Роман Геев. All rights reserved.
//


import Foundation
import UIKit

func calcFloat(coord : CGFloat, length : CGFloat, size : CGFloat) -> CGFloat {
    return coord * length - 0.5 * size;
}

func calcCenter(coord : CGPoint, frame : CGSize, size : CGSize) -> CGPoint {
    return CGPoint(x : calcFloat(coord: coord.x, length: frame.width, size: size.width),
                   y: calcFloat(coord: coord.y, length: frame.height, size: size.height))
}

func getRectSize(parentFrame: CGRect, params: SizeParameters) -> CGSize {
    let s : CGFloat = params.square * parentFrame.width * parentFrame.height
    let height : CGFloat = sqrt(CGFloat(s) / params.k)
    let width : CGFloat = params.k * height
    let size = CGSize(width: width, height: height)
    return size
}

func getRect(parentFrame : CGRect, params : LocationParameters) -> CGRect {
    let size = getRectSize(parentFrame: parentFrame, params: params)
    let center = calcCenter(coord: params.centerPoint, frame: parentFrame.size, size: size)
    return CGRect(origin: center, size: size)
}

extension UIView {
    
    func posSubviewByRect(subView : UIView, location : LocationParameters) {
        subView.frame = getRect(parentFrame: self.frame, params: location)
        self.addSubview(subView)
    }
    
    func addButton(label : String, target: Any?, selector: Selector, params : LocationParameters) -> UIButton {
        let result = UIButton();
        result.addTarget(target, action: selector, for: .touchUpInside)
        result.setUpButton(label : label, color : .black, translatesMask: true)
        self.posSubviewByRect(subView: result, location: params)
        return result
    }
}

extension Array {
    func firstTrueBound(predicate: (Element) -> Bool) -> Index {
        var low = startIndex
        var high = endIndex
        while low < high {
            let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
            if (predicate(self[mid])) {
                high = mid
            } else {
                low = index(after: mid)
            }
        }
        assert(low >= 0);
        assert(low <= self.count);
        return low
    }
}
