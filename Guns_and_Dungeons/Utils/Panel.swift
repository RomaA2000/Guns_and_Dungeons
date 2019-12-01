//
//  Panel.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import Foundation
import UIKit

class Panel<Element: PanelSubview>: UIImageView {
    typealias Params = Element.Params
    
    var panelSubviews: [Element] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, defaultImage: UIImage?) {
        self.init(frame: frame)
        self.image = defaultImage
        self.isUserInteractionEnabled = true
    }
    
    func addSubviewsEvenly(elementsParams: [Params]) {
        let params = elementsParams
        for param in params {
            param.setFrame(frame: getRect(parentFrame: self.frame, params: param.getLocationParams()))
        }
        let elements: [Element] = params.map({ return Element(params: $0) })
        let number: Int = elements.count
        guard number % 2 == 0, let viewSize = elements.first?.frame.size else { return }
        var rows: Int = 2
        var colomns: Int = number / 2
        let bias: Int = Int(sqrt(Double(number)))
        for conformRows in (0...bias).reversed() {
            if (number % rows == 0) {
                rows = conformRows
                break
            }
        }
        colomns = number / rows
        let x_dist = (self.bounds.width - viewSize.width * CGFloat(colomns)) / CGFloat(colomns + 1)
        let y_dist = (self.bounds.height - viewSize.height * CGFloat(rows)) / CGFloat(rows + 1)
        let x_arr: [CGFloat] = Array(stride(from: x_dist + viewSize.width / 2,
                                            to: self.bounds.width - 1, by: x_dist + viewSize.width))
        let y_arr: [CGFloat] = Array(stride(from: y_dist + viewSize.height / 2,
                                            to: self.bounds.height - 1, by: y_dist + viewSize.height))
        guard x_arr.count * y_arr.count == number else { return }
        var current_element: Int = 0
        for y in y_arr {
            for x in x_arr {
                let viewSize: CGSize = elements[current_element].frame.size
                elements[current_element].frame.origin = CGPoint(x: x - viewSize.width / 2, y: y - viewSize.height / 2)
                addSubview(elements[current_element])
                panelSubviews.append(elements[current_element])
                current_element += 1
            }
        }
    }
    
    func setElement(number: Int, elementParams: Params) {
        guard number < panelSubviews.count else { fatalError() }
        let lastFrame: CGRect = panelSubviews[number].frame
        let params: Params = elementParams
        params.setFrame(frame: lastFrame)
        panelSubviews[number].removeFromSuperview()
        let newElement = Element(params: params)
        addSubview(newElement)
        panelSubviews[number] = newElement
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
