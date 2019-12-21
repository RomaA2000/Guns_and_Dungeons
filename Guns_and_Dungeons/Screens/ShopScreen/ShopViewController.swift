//
//  ShopViewController.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 18/10/2019.
//  Copyright © 2019 Александр Потапов. All rights reserved.
//
import Foundation
import UIKit

class ShopViewController : UIViewController {

    var backButton: UIButton!
    var previewer: UIReviewer!
    var tabsView: TabsView!
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        createTabView()
        
        let backButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.8, y: 0.9), k: 1.25, square: 0.006)
        backButton = self.view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen), params: backButtonParams)
        backButton.setBackgroundImage(UIImage(named: "unlocked"), for: .normal)

        let previewerLocationParams = LocationParameters(centerPoint: CGPoint(x: 0.15, y: 0.5), k: 0.4, square: 0.09)
        let previewerRect = getRect(parentFrame: view.bounds, params: previewerLocationParams)
        let previewerParams = UIReviewerPrams(frame: previewerRect, backImage: UIImage(named: "unlocked"))
        previewer = UIReviewer(params: previewerParams)
        self.view.addSubview(previewer)

        previewer.setCharacteristics(pack: CharactPack(speed: 1, armor: 2, hp: 3, damage: 4))


        let labelLocationParams = LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.1), k: 5, square: 0.2)
        label = UILabel(frame: getRect(parentFrame: self.view.bounds, params: labelLocationParams))
        label.text = "Shop"
        label.textAlignment = .center
        self.view.addSubview(label)
    }


    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func createTabView() {
        let tabsViewParams = LocationParameters(centerPoint: CGPoint(x: 0.6, y: 0.5), k: 1.5, square: 0.4)
        let buttonToGuns = UIButton()
        buttonToGuns.setTitle("To guns", for: .normal)
        buttonToGuns.backgroundColor = .red
        let buttonToBases = UIButton()
        buttonToBases.setTitle("TO bases", for: .normal)
        buttonToBases.backgroundColor = .red
        let tabsViewRect = getRect(parentFrame: self.view.bounds, params: tabsViewParams)
        
        //let netCollector = NetCollector()
        //netCollector.startLoadingData()
        
        var allCellsData: AllCellsData
        let path = Bundle.main.path(forResource: "items_description", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            print(data)
            allCellsData = try JSONDecoder().decode(AllCellsData.self, from: data)
        } catch {
            fatalError("JSON data not found")
        }
        
        var cellsSec1: [CellInfo] = []
        for i in allCellsData.bases {
            let image = UIImage(named: i.image)
            let backGroundImage = UIImage(named: "unlocked")
            let cost = i.cost
            cellsSec1.append(CellInfo(itemImage: image, backgroundImage: backGroundImage, unlocked: false, cost: cost))
        }
        
        var cellsSec2: [CellInfo] = []
        for i in allCellsData.guns {
            let image = UIImage(named: i.image)
            let backGroundImage = UIImage(named: "unlocked")
            let cost = i.cost
            cellsSec2.append(CellInfo(itemImage: image, backgroundImage: backGroundImage, unlocked: false, cost: cost))
        }
        
        
        
        let tabsDesctriptionSec1 = TabDescription(cellInfos: cellsSec2)
        let tabsDesctriptionSec2 = TabDescription(cellInfos: cellsSec1)
        
        tabsView = TabsView(frame: tabsViewRect, tabPart: 0.1,
                            tabs: [buttonToGuns, buttonToBases],
                            tabsDesctriptions: [tabsDesctriptionSec1, tabsDesctriptionSec2])
        self.view.addSubview(tabsView)
        tabsView.delegate = self
    }
}

extension ShopViewController: TabsViewDelegate {
    func tabSelected(tabNumber: Int) {
        print("new tab selected")
    }
    
    func itemSelected(tabNumber: Int) {
        print("new item selected")
    }

}
