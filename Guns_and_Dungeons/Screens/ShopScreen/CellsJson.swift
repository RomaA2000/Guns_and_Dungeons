//
//  CellsJson.swift
//  Guns_and_Dungeons
//
//  Created by Александр Потапов on 17.12.2019.
//  Copyright © 2019 Роман Агеев. All rights reserved.
//

import Foundation

struct AllCellsData: Decodable {
    let guns: Array<CellDecsription>
    let bases: Array<CellDecsription>
}

struct CellDecsription: Decodable {
    let name: String
    let image: String
    let cost: Int
}
