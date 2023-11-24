//
//  ModelProtocol.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation

class Model{
    private(set) var player: Player
    private(set) var monster: Monster?
    
    init(){
        self.player = Player(name: "no name")
    }
    
    init(playerName: String){
        self.player = Player(name: playerName)
    }
    
    func setMonster(monster: Monster?){
        self.monster = monster
    }
}
