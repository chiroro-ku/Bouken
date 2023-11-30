//
//  MonsterData.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/30.
//

import Foundation

class MonsterData: ProfileData{
    
    private var list: [Monster] = []
    
    var delegete: MonsterProtocol?{
        didSet{
            for monster in list{
                monster.delegete = self.delegete
            }
        }
    }
    
    init() {
        super.init(fileName: "MonsterData")
        for aData in self.data {
            let monster = Monster(data: aData)
            monster.delegete = self.delegete
            self.list.append(monster)
        }
    }
    
    func getRandomMonster() -> Monster{
        guard let monster = self.list.randomElement() else {
            return Monster()
        }
        return monster
    }
    
    func getMonster(name: String) -> Monster?{
        for monster in self.list {
            if monster.name == name{
                return monster
            }
        }
        return nil
    }
}
