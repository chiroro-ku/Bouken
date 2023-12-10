//
//  Monster.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation
class Monster{
    
    private var eventFlag = false
    
    private(set) var name: String
    private(set) var ration: Int
    private(set) var damege: Int
    private(set) var image: String
    private(set) var text: String
    private(set) var event: String
    private(set) var eventValue: String
    
    private(set) var death: Bool = false
    
    var delegete: MonsterProtocol?
    
    init() {
        self.name = "no name"
        self.ration = 0
        self.damege = 0
        self.image = "no image"
        self.text = "no text"
        self.event = "no event"
        self.eventValue = "no value"
    }
    
    init(data: String) {
        let datas = data.components(separatedBy: ",")
        self.name = datas[0]
        self.ration = Int(datas[1]) ?? 0
        self.damege = Int(datas[2]) ?? 0
        self.image = datas[3]
        self.text = datas[4]
        self.event = datas[5]
        self.eventValue = datas[6]
    }
    
    func setRation(ration: Int){
        self.ration = ration
    }
    
    func takeAttack(player: Player, bool: Bool = false){
        if bool {
            self.death = true
            return
        }
        let ration = self.ration - player.lv
        let random = Int.random(in: 1...100)
        self.death = random > ration
    }
    
    func loadEvent(){
        guard let delegete = self.delegete else {
            return
        }
        delegete.loadMonsterEvent()
    }
    
    func appendEvent(){
        if self.eventFlag {
            return
        }
        guard let delegete = self.delegete else {
            return
        }
        let bool = delegete.appendMonsterEvent()
        self.eventFlag = bool
    }
    
    func respawn(){
        self.eventFlag = false
        self.death = false
    }
}
