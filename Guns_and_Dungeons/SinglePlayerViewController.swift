//
//  SinglePlayerViewController.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18/10/2019.
//  Copyright © 2019 точно не Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

class Panel {
    let buttons : [UIButton]
    let mainView : UIView
    let center : CGPoint
    init(frame: CGRect) {
        center = frame.origin
        buttons = []
        mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = .yellow
    }
    func addButton() {}
}

class SinglePlayerViewController : UIViewController, UIScrollViewDelegate {
    
    let levelPanel: UIScrollView = UIScrollView()
    var backButton: UIButton = UIButton()
    var levelNumber : Int = 0
    // MARK: - когда подгружать информацию о уровнях
    var panels: [Panel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let k_scroll = view.bounds.width / (0.6 * view.bounds.height)
        self.view.posSubviewByRect(subView: levelPanel,
                                   params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.4), k: k_scroll , square: 0.6))
        levelPanel.backgroundColor = .gray
        backButton = self.view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                         params: AllParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        levelNumber = 16
        //temporary
        levelPanel.isScrollEnabled = true
//        levelPanel.isPagingEnabled = true
        fillLevelPanel(number: 3)
        levelPanel.delegate = self
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let position = targetContentOffset.pointee.x
        print(position)
        let last: Int = panels.lastIndex(where: { (current: Panel) -> Bool in
            return current.mainView.center.x < position
        }) ?? panels.count - 1
        let next: Int = last != panels.count - 1 ? last + 1 : panels.count - 1
        
        print(last, " ", next)
        let nearest: CGFloat = (panels[last].center.x + panels[next].center.x < 2 * position) ? panels[last].center.x : panels[next].center.x
        targetContentOffset.pointee.x = nearest
    }
    
    func addPanel(locationRect: CGRect) -> UIView {
        panels.append(Panel(frame: locationRect))
        return panels.last!.mainView
    }
    
    func fillLevelPanel(number: Int) {
        let panelPart : CGFloat = 0.6
        var imageRect : CGRect = CGRect(x: 0, y: 0, width: levelPanel.bounds.width * panelPart, height: levelPanel.bounds.height)
        let marginX : CGFloat = levelPanel.bounds.width * 0.05
        let startMargin : CGFloat = (levelPanel.bounds.width - imageRect.width) / 2
        for i in 0..<number {
            if (i == 0) {
                imageRect.origin.x += startMargin - marginX
            }
            imageRect.origin.x += marginX
            levelPanel.addSubview(addPanel(locationRect: imageRect))
            imageRect.origin.x += imageRect.width + marginX
        }
        levelPanel.contentSize = CGSize(width: startMargin * 2 + marginX * CGFloat(2 * (number - 1)) + imageRect.width * CGFloat(number), height: imageRect.height)
    }
    
    @objc func toMenuScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
