//
//  EventModel.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/13.
//

import Foundation

class EventModel{
    func isPlayerAttack(player: Player, monster: Monster) -> Bool{
        let monsterRation = monster.getRation()
        let playerLv = player.getLv()
        let ration = monsterRation - playerLv
        let random = Int.random(in: 0..<100)
        let bool = random > ration
        return bool
    }
}
