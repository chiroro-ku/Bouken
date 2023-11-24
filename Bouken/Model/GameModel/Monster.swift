//
//  Monster.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation
class Monster{
    private(set) var name: String
    private(set) var ration: Int
    private(set) var damege: Int
    private(set) var image: String
    private(set) var event: String
    
    private(set) var death: Bool = false
    
    init() {
        self.name = "no name"
        self.ration = 0
        self.damege = 0
        self.image = "no image"
        self.event = "no event"
    }
    
    init(data: String) {
        let datas = data.components(separatedBy: ",")
        self.name = datas[0]
        self.ration = Int(datas[1]) ?? 0
        self.damege = Int(datas[2]) ?? 0
        self.image = datas[3]
        self.event = datas[4]
    }
    
    func takeAttack(player: Player){
        let ration = self.ration - player.lv
        let random = Int.random(in: 1...100)
        self.death = random > ration
    }
}
