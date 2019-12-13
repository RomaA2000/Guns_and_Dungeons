//
//  TabsView.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потау on 11.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import UIKit

protocol TabsViewDelegate: class {
    func tabSelected(tabNumber: Int)
}

class TabsView: UIView {
    
    let tabPanel: UIImageView
    let tabs: [UIButton]
    weak var delegate: TabsViewDelegate?
    var activeTab: UIButton
    let table: UICollectionView
    var cellColor: UIColor = .green
    var activeTabNumber: Int {
        get {
            return activeTab.tag
        }
    }
    let tabsDesctription: [TabDescription]
    
    init(frame: CGRect, tabPart: CGFloat, tabs: [UIButton], tabsDesctriptions: [TabDescription]) {
        self.tabsDesctription = tabsDesctriptions
        let tabPanelSize = CGSize(width: frame.width, height: frame.height * tabPart)
        self.tabPanel = UIImageView(frame: CGRect(origin: CGPoint.zero, size: tabPanelSize))
        self.tabs = tabs
        self.activeTab = tabs[0]
        
        let tableRect = CGRect(x: 0, y: tabPanelSize.height, width: frame.width, height: frame.height - tabPanelSize.height)
        let layout = UICollectionViewFlowLayout()
        
        let itemsAtOneLine: CGFloat = 3
        let spacingBetween: CGFloat = tableRect.width * 0.01
        let cellWidth: CGFloat = (frame.width - spacingBetween * (itemsAtOneLine - 1)) / itemsAtOneLine
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = spacingBetween
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.7)
        self.table = UICollectionView(frame: tableRect, collectionViewLayout: layout)
        
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
        
        table.dataSource = self
        table.delegate = self
        table.register(TableItemCell.self, forCellWithReuseIdentifier: TableItemCell.identyfire)
        
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
            
            self.table.resetScrollPositionToTop()
            if cellColor == .green {
                cellColor = .cyan
            }
            else {
                cellColor = .green
            }
            self.table.reloadData()
        }
    }
    
    let identifier = "identifier"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TableItemCell
        cell.setData(image: <#T##UIImage#>, background: <#T##UIImage#>, text: <#T##String#>)
        cell.backgroundColor = cellColor
        return cell
    }
    
}


extension UIScrollView {
    /// Sets content offset to the top.
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}
