//
//  SinglePlayerViewController.swift
//  Guns_and_Dungeons
//
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation
import UIKit

class PanelButton : UIButton {
    let number: Int
    init(frame: CGRect, num: Int) {
        number = num
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Panel {
    let mainView : UIView
    static let k : CGFloat = CGFloat(1)
    static let square  : CGFloat = CGFloat(0.1)
    static let cordinates : [AllParameters] = [
        AllParameters(centerPoint: CGPoint(x: 0.25, y: 0.25), k: k, square: square),
        AllParameters(centerPoint: CGPoint(x: 0.75, y: 0.25), k: k, square: square),
        AllParameters(centerPoint: CGPoint(x: 0.25, y: 0.75), k: k, square: square),
        AllParameters(centerPoint: CGPoint(x: 0.75, y: 0.75), k: k, square: square)]
    
    init(frame: CGRect) {
        mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = .green
    }
}

class SinglePlayerViewController : UIViewController, UIScrollViewDelegate {
    let levelPanel: UIScrollView = UIScrollView()
    var backButton: UIButton = UIButton()
    var levelNumber: Int = 0
    var marginStart: CGFloat = 0
    var marginMiddle: CGFloat = 0
    var panelWidth: CGFloat = 0
    var panels: [Panel] = []
    static var nowPanel : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let k_scroll = view.bounds.width / (0.6 * view.bounds.height)
        view.posSubviewByRect(subView: levelPanel,
                                   params: AllParameters(centerPoint: CGPoint(x: 0.5, y: 0.4), k: k_scroll , square: 0.6))
        levelPanel.backgroundColor = .gray
        backButton = view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen),
                                         params: AllParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.005))
        levelNumber = 10
        levelPanel.isScrollEnabled = true
        levelPanel.showsHorizontalScrollIndicator = false
        fillLevelPanel(number: levelNumber)
        levelPanel.contentOffset = CGPoint(x: panels[SinglePlayerViewController.nowPanel].mainView.center.x - levelPanel.bounds.width / 2, y: 0)
        levelPanel.delegate = self
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let position = targetContentOffset.pointee.x + levelPanel.bounds.width / 2
        var targetX: CGFloat = 0;
        var idx : Int = 0
        if (position > levelPanel.bounds.width / 2) {
            idx = Int((position - levelPanel.bounds.width / 2) / (panelWidth + marginMiddle * 2))
            if (idx >= panels.count - 1) {
                idx = panels.count - 1
            } else {
                idx += position - panels[idx].mainView.center.x > panels[idx + 1].mainView.center.x - position ? 0 : 1
            }
        }
        SinglePlayerViewController.nowPanel = idx
        targetX = panels[idx].mainView.center.x - levelPanel.bounds.width / 2
        targetContentOffset.pointee.x = targetX
    }
    
    @objc func buttonPressed(sender: PanelButton) {
        print(sender.number)
        sender.backgroundColor = .yellow
    }
    
    func addPanel(locationRect: CGRect) -> UIView {
        panels.append(Panel(frame: locationRect))
        var numerator: Int = 0
        for i in 0..<4 {
            let now : PanelButton = PanelButton(frame: CGRect(), num: numerator)
            panels.last!.mainView.posSubviewByRect(subView: now, params: Panel.cordinates[i])
            numerator += 1
            now.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
        return panels.last!.mainView
    }
    
    func fillLevelPanel(number: Int) {
        let panelPart : CGFloat = 0.6
        var imageRect : CGRect = CGRect(x: 0, y: 0, width: levelPanel.bounds.width * panelPart, height: levelPanel.bounds.height)
        panelWidth = imageRect.width
        marginMiddle = levelPanel.bounds.width * 0.05
        marginStart = (levelPanel.bounds.width - imageRect.width) / 2
        for i in 0..<number {
            if (i == 0) {
                imageRect.origin.x += marginStart - marginMiddle
            }
            imageRect.origin.x += marginMiddle
            levelPanel.addSubview(addPanel(locationRect: imageRect))
            imageRect.origin.x += imageRect.width + marginMiddle
        }
        levelPanel.contentSize = CGSize(width: marginStart * 2 + marginMiddle * CGFloat(2 * (number - 1)) + imageRect.width * CGFloat(number), height: imageRect.height)
    }
    
    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
}
