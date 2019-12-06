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

class SizeParameters {
    var k : CGFloat = CGFloat()
    var square : CGFloat = CGFloat()
    init(k : CGFloat, square : CGFloat) {
        self.k = k;
        self.square = square;
    }
}

class LocationParameters : SizeParameters {
    var centerPoint : CGPoint = CGPoint()
    init(centerPoint : CGPoint, k : CGFloat, square : CGFloat) {
        self.centerPoint = centerPoint
        super.init(k : k, square : square)
    }
    init(copy: LocationParameters) {
        self.centerPoint = copy.centerPoint
        super.init(k: copy.k, square: copy.square)
    }
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
    
    func getRectInSelf(location: LocationParameters) -> CGRect {
        return getRect(parentFrame: self.bounds, params: location)
    }
    
    func addButton(label : String, target: Any?, selector: Selector, params : LocationParameters) -> UIButton {
        let result = UIButton();
        result.addTarget(target, action: selector, for: .touchUpInside)
        result.setUpButton(label : label, color : .black, translatesMask: true)
        self.posSubviewByRect(subView: result, location: params)
        return result
    }
    
    func animateTo(centerPoint: CGPoint, duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.center = centerPoint
        }, completion: completion)
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

extension CGRect {
    init(centerPoint: CGPoint, size: CGSize) {
        self.init(x: centerPoint.x - size.width / 2, y: centerPoint.y - size.height / 2, width: size.width, height: size.height)
    }
    
    mutating func resizeAtPoint(newSize: CGSize) {
        origin = CGPoint(x: self.origin.x - newSize.width / 2, y: self.origin.y - newSize.height / 2)
        size = newSize
    }
}

extension CGPoint {
    func getLenOfVector() -> CGFloat {
        return sqrt(pow(self.x, 2) + pow(self.y, 2))
    }
}
