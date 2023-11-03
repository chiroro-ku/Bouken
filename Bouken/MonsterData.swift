//
//  MonsterData.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/30.
//

import Foundation

class MonsterData: ProfileData{
    
    private var list: [Monster] = []
    
    init() {
        super.init(fileName: "MonsterData")
        for aData in self.data {
            self.list.append(Monster(data: aData))
        }
    }
    
    func getRandomMonster() -> Monster{
        guard let monster = self.list.randomElement() else {
            return Monster()
        }
        return monster
    }
}
