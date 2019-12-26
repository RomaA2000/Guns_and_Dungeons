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
    var tabsView: TabsView!
    var tabsDesctription: [TabDescription] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        createTabView()

        let backButtonParams = LocationParameters(centerPoint: CGPoint(x: 0.9, y: 0.9), k: 1.25, square: 0.006)
        backButton = self.view.addButton(label: "Back", target: self, selector: #selector(toMenuScreen), params: backButtonParams)
        backButton.setBackgroundImage(UIImage(named: "unlocked"), for: .normal)
    }

    @objc func toMenuScreen() {
        navigationController?.popViewController(animated: true)
    }

    func generateUpdater(number: Int) -> (UIImage?, Int) -> Void {
        return { (image: UIImage?, cellNumber: Int) -> Void in
            if let data = image {
                self.tabsDesctription[number].cellInfos[cellNumber].itemImage = data
                self.tabsView.table.reloadData()
            }
        }
    }

    func createTabView() {
        let tabsViewParams = LocationParameters(centerPoint: CGPoint(x: 0.5, y: 0.5), k: 1.5, square: 0.5)
        let buttonToGuns = UIButton()
        buttonToGuns.setTitle("To guns", for: .normal)
        buttonToGuns.backgroundColor = .red
        let buttonToBases = UIButton()
        buttonToBases.setTitle("To bases", for: .normal)
        buttonToBases.backgroundColor = .red
        let tabsViewRect = getRect(parentFrame: self.view.bounds, params: tabsViewParams)

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

        tabsDesctription = [tabsDesctriptionSec1, tabsDesctriptionSec2]

        tabsView = TabsView(frame: tabsViewRect, tabPart: 0.1,
                            tabs: [buttonToGuns, buttonToBases],
                            tabsDesctriptions: [tabsDesctriptionSec1, tabsDesctriptionSec2])
        self.view.addSubview(tabsView)
        tabsView.delegate = self

        let netCollector = NetCollector(gunsSelector: self.generateUpdater(number: 0),
                                        basesSelector: self.generateUpdater(number: 1))
        let gunUrl = URL(string:"https://psv4.userapi.com/c856336/u251664583/docs/d12/f1b149d62a0f/rocket1.png?extra=ngAxzY5aFg6SDD_mnOuCQ61jWty02RGY3wXfGAFsXuELjBH4WYqDPbucoO4ErljAh93fgVjur9tyhw_QY2BtD5Uk5zgaTB-6yGUXOEuNUmrOJIVHt-OVVmUNLqhEdiRMDjiExtFkOsdTZtzyXhMAlSA")!
        let gunsUrl: Array<(URL, Int)> =
            [(gunUrl, 6),
            (gunUrl, 7),
            (gunUrl, 8)]
        let baseUrl = URL(string: "https://psv4.userapi.com/c856416/u251664583/docs/d3/54c05b31018f/en1.png?extra=R6rsMIL7FSyMa6Q7QfTEGqxG6xkOl_I5eooGYkeWaZHyXvLJ4VJc_diCaetwvAQyJrMc5LMdUi-3oAQhR7nPQDSh0Htgx4BbUCVSiavbKOIDHRhae7hGOXxyr02fa9EObI7CGTRhu42e-OhtrIGLHxQ")!
        let basesUrl: Array<(URL, Int)> =
            [(baseUrl, 6),
             (baseUrl, 7),
             (baseUrl, 8)]
        netCollector.startLoadingData(urlsGunsPos: gunsUrl, urlsBasesPos: basesUrl)
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
