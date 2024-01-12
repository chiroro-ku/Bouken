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
            for monster in self.list{
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
        guard let monster = self.list.randomElement(), let nextMonster = self.list.randomElement() else {
            return Monster()
        }
        if monster.ration < nextMonster.ration{
            return nextMonster
        }
        return monster
    }
    
    func getMonster(name: String) -> Monster?{
        for monster in self.list {
            if monster.name == name{
                return monster
            }
        }
        print("error MonsterData.getMonster() name: " + name)
        return nil
    }
    
    func getFirstMonsterList() -> [Monster]{
        var monsters: [Monster] = []
        for monster in self.list {
            let typeName = monster.type
            for aMonster in monsters{
                if aMonster.name == typeName{
                    continue
                }
            }
            monsters.append(self.getMonster(name: typeName) ?? Monster())
            print(typeName)
        }
        monsters.removeFirst()
        return monsters
    }
    
    func getFirstMonsterList(ration: Int) -> [Monster]{
        var monsters: Set<Monster> = []
        for aMonster in self.list{
            if
        }
    }
}
