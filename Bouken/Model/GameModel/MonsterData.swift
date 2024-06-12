//
//  MonsterData.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/30.
//

import Foundation
import RealmSwift

class MonsterData {
    
    private let fileName = "MonsterData"
    
    init() {
        let realm = try! Realm()
        let monsters = realm.objects(Monster.self)
        if !monsters.isEmpty{
            return
        }
        
        guard let path = Bundle.main.path(forResource: self.fileName, ofType: "csv") else {
            print("file error")
            return
        }
        
        var allData = ""
        var lineData: [String] = []
        do{
            allData = try String(contentsOfFile: path, encoding: .utf8)
            lineData = allData.components(separatedBy: "\r\n")
        }catch let error as NSError {
            print("\(error)")
        }
        lineData.removeFirst()
//            self.data.removeLast()
        
        for data in lineData {
            
            let prameterData = data.components(separatedBy: ",")
            let monster = Monster()
            monster.id = Int(prameterData[0]) ?? 0
            monster.rank = Int(prameterData[1]) ?? 0
            monster.name = prameterData[2]
            monster.ration = Int(prameterData[3]) ?? 0
            monster.damege = Int(prameterData[4]) ?? 0
            monster.imageName = prameterData[5]
            monster.text = prameterData[6]
            monster.event = prameterData[7]
            monster.eventValue = prameterData[8]
            monster.type = prameterData[9]
            monster.next = prameterData[10]
            monster.level = Int(prameterData[11]) ?? 0
            
            try! realm.write{
                realm.add(monster)
            }
        }
    }
    
    func get(name: String) -> [Monster]{
        let realm = try! Realm()
        let monsters = realm.objects(Monster.self).where{
            $0.name == name
        }
        if monsters.count > 1{
            print("MonsterData - getMonster(\(name))")
        }
        return Array(monsters)
    }
    
    func get(level: Int) -> [Monster]{
        let realm = try! Realm()
        let monsters = realm.objects(Monster.self).where{
            $0.level == level
        }
        return Array(monsters)
    }
}
