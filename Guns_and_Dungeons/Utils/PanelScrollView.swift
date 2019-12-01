//
//  PanelScrollView.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 15.11.2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//

import Foundation
import UIKit

protocol PanelSuviewParams: class {
    func setFrame(frame: CGRect)
    func getLocationParams() -> LocationParameters
}

protocol PanelSubview: UIView {
    associatedtype Params: PanelSuviewParams
    init(params: Params)
}

class PanelsScrollView<Element: PanelSubview> : UIScrollView, UIScrollViewDelegate {
    typealias PanelType = Panel<Element>
    
    var panels: [PanelType] = []
    let margins: MarnginsInformation
    let elementsPerPanel: Int
    
    init(frame: CGRect = CGRect(), elementsPerPanel: Int) {
        self.elementsPerPanel = elementsPerPanel
        margins = MarnginsInformation()
        super.init(frame: frame)
    }
    
    init(parrentBounds: CGRect, panelsNumber: Int, elementsPerPanel: Int) {
        self.elementsPerPanel = elementsPerPanel
        let k_scroll = parrentBounds.size.width / (0.6 * parrentBounds.size.height)
        let panelParams = LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.4), k: k_scroll , square: 0.6)
        let scrollFrame = getRect(parentFrame: parrentBounds, params: panelParams)
        let panelWidth: CGFloat = 0.6 * scrollFrame.width
        let margins: MarnginsInformation = MarnginsInformation(marginStart: (scrollFrame.width - panelWidth) / 2,
                                                               marginMiddle: scrollFrame.width * 0.05,
                                                               panelWidth: scrollFrame.width * 0.6)
        self.margins = margins
        super.init(frame: scrollFrame)
        var locationRect: CGRect = CGRect(x: margins.marginStart, y: 0, width: margins.panelWidth, height: bounds.height)
        for _ in 0..<panelsNumber {
            addPanel(frame: locationRect, image: nil)
            locationRect.origin.x += margins.marginMiddle + margins.panelWidth
        }
        
        contentSize = CGSize(width: 2 * margins.marginStart + CGFloat(panelsNumber) * margins.panelWidth + CGFloat(panelsNumber - 1) * margins.marginMiddle, height: bounds.height)
        isScrollEnabled = true;
        showsHorizontalScrollIndicator = false
        delegate = self
    }
    
    func addPanel(frame: CGRect, image: UIImage?) {
        let panel = PanelType(frame: frame, defaultImage: image)
        panel.layer.cornerRadius = 10
        panel.layer.masksToBounds = true
        panel.backgroundColor = .green
        addSubview(panel)
        panels.append(panel)
    }
    
    func createElementsOnPanels(params: [Element.Params]) {
        for elementsNumber in 0..<panels.count {
            let leftBound: Int = elementsNumber * elementsPerPanel
            let rightBound: Int = (elementsNumber + 1) * elementsPerPanel
            panels[elementsNumber].addSubviewsEvenly(elementsParams: Array(params[leftBound..<rightBound]))
        }
    }
    
    func setElement(number: Int, params: Element.Params) {
        guard number < panels.count * elementsPerPanel else { fatalError("") }
        panels[number / elementsPerPanel].setElement(number: number % elementsPerPanel, elementParams: params)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let position = targetContentOffset.pointee.x + bounds.width / 2
        var targetX: CGFloat = 0;
        var idx : Int = 0
        if (position > bounds.width / 2) {
            idx = Int((position - bounds.width / 2) / (margins.panelWidth + margins.marginMiddle * 2))
            if (idx >= panels.count - 1) {
                idx = panels.count - 1
            } else {
                idx += position - panels[idx].center.x > panels[idx + 1].center.x - position ? 1 : 0
            }
        }
        targetX = panels[idx].center.x - bounds.width / 2
        targetContentOffset.pointee.x = targetX
    }
    
    //MARK: - Иногда при резком отпускании вбок кнопка обратно не отжимается, потом поправить
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
