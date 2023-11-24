//
//  Player.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class _Player{
    
    private var name: String
    private var lv: Int
    private var maxHP: Int
    private var hp: Int {
        didSet{
            if self.hp > self.maxHP {
                self.hp = self.maxHP
            }else if self.hp <= 0{
                self.hp = 0
            }
            
        }
    }
    
    var death: Bool{
        get{
            self.hp == 0
        }
    }
    
    init(name: String){
        self.name = name
        self.lv = 1
        self.maxHP = 100
        self.hp = 100
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getLv() -> Int {
        return self.lv
    }
    
    func getHP() -> Int {
        return self.hp
    }
    
    func getMaxHP() -> Int{
        return self.maxHP
    }
    
    func levelUP() {
        self.lv += 1
        self.maxHP += 10
        self.hp += Int(Float(self.maxHP - self.hp) * 0.3) + 10
    }
    
    func receiveDamage(value: Int) {
        self.hp -= value
        if self.hp < 0 {
            self.hp = 0
        }
    }
    
    func escape() {
        self.receiveDamage(value: 10)
    }
}
