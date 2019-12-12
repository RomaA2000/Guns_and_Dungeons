//
//  TabsView.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 11.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

protocol TabsViewDelegate: class {
    func tabSelected(tabNumber: Int)
}

class TabsView: UIView {
    
    let tabPanel: UIImageView
    var tabs: [UIButton]
    weak var delegate: TabsViewDelegate?
    var activeTab: UIButton
    let table: UICollectionView
    
    init(frame: CGRect, tabPart: CGFloat, tabs: [UIButton]) {
        let tabPanelSize = CGSize(width: frame.width, height: frame.height * tabPart)
        self.tabPanel = UIImageView(frame: CGRect(origin: CGPoint.zero, size: tabPanelSize))
        self.tabs = tabs
        self.activeTab = tabs[0]
        
        let tableRect = CGRect(x: 0, y: tabPanelSize.height, width: frame.width, height: frame.height - tabPanelSize.height)
        self.table = UICollectionView(frame: tableRect, collectionViewLayout: UICollectionViewFlowLayout())
        
        super.init(frame: frame)
        self.backgroundColor = .green
        self.tabPanel.backgroundColor = .yellow
        let tabWidth: CGFloat = (tabPanel.bounds.width * 0.9) / CGFloat(tabs.count)
        let tabMiddleSpace: CGFloat = (tabPanel.bounds.width - tabWidth * CGFloat(tabs.count)) / (CGFloat(tabs.count + 1))
        let tabHeight: CGFloat = tabPanel.bounds.height
        var tabFrame = CGRect(x: tabMiddleSpace, y: 0, width: tabWidth, height: tabHeight)
        for buttonNumber in 0..<tabs.count {
            tabs[buttonNumber].frame = tabFrame
            tabs[buttonNumber].tag = buttonNumber
            tabs[buttonNumber].addTarget(self, action: #selector(tabSelected(_:)), for: .touchUpInside)
            tabs[buttonNumber].addTarget(self, action: #selector(tabPressed(_:)), for: .touchDown)
            tabs[buttonNumber].addTarget(self, action: #selector(tabRealisedOutisde(_:)), for: .touchUpOutside)
            tabPanel.addSubview(tabs[buttonNumber])
            tabFrame.origin.x += (tabWidth + tabMiddleSpace)
            tabs[buttonNumber].alpha = 0.5
        }
        self.addSubview(tabPanel)
        self.isUserInteractionEnabled = true
        self.tabPanel.isUserInteractionEnabled = true
        self.tabs[0].alpha = 1
        
        self.addSubview(table)
    }
    
    @objc func tabPressed(_ sender: UIButton) {
        sender.alpha = 1
    }
    
    @objc func tabRealisedOutisde(_ sender: UIButton) {
        if (sender != activeTab) {
            sender.alpha = 0.5
        }
    }
    
    @objc func tabSelected(_ sender: UIButton) {
        if (sender != activeTab) {
            activeTab.alpha = 0.5
            sender.alpha = 1
            activeTab = sender
            self.delegate?.tabSelected(tabNumber: sender.tag)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
