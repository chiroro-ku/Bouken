//
//  EventProtocol.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/30.
//

import Foundation

protocol EventProtocol {
    func getPlayerName() -> String
    func getMonsterName() -> String
    func getPlayer() -> Player
    func getMonster() -> Monster
    func setMonster(monster: Monster)
}
