//
//  BoukenMonsterData.swift
//  Bouken
//
//  Created by 小林千浩 on 2024/01/12.
//

import Foundation

class BoukenMonsterData: MonsterData{
    var typeMonsterList: [Monster] = []
    
    override init(){
        super.init()
        
        self.typeMonsterList = super.getTypeMonsterList()
    }
    
    override func getTypeMonsterList(less ration: Int) -> [Monster] {
        let monsterList = self.typeMonsterList
        var returnList: [Monster] = []
        for monster in monsterList{
            if monster.ration < ration{
                if let appendMonster = self.removeTypeMonster(name: monster.name){
                    returnList.append(appendMonster)
                }
            }
        }
        return returnList
    }
    
    func removeTypeMonster(name: String) -> Monster?{
        for i in 0 ..< self.typeMonsterList.count{
            if self.typeMonsterList[i].name == name{
                return self.typeMonsterList.remove(at: i)
            }
        }
        return nil
    }
    
    func getRandomTypeMonster() -> Monster? {
        if self.typeMonsterList.count == 0{
            return nil
        }
        let random = Int.random(in: 0..<self.typeMonsterList.count)
        let monster = self.typeMonsterList.remove(at: random)
        return monster
    }
}
