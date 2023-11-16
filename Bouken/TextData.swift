//
//  TextData.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class TextData {
    
    let errorText = "error"
    var delegate: EventProtocol?
    
    private func getPlayerName() -> String {
        guard let delegate = self.delegate else {
            return errorText
        }
        return delegate.getPlayerName()+" "
    }
    
    private func getMonsterName() -> String {
        guard let delegate = self.delegate else {
            return errorText
        }
        return delegate.getMonsterName()+" "
    }
    
    func getTextList(eventType: EventType) -> GameText {
        var text: String = ""
        var textList = GameText(text: text)
        switch eventType{
        case .system(.first):
            text  = "ここをタップ！,冒険に行くぞ！,強そうなモンスターは,危険だから逃げよう！"
            textList = GameText(text: text)
            break
        case .system(.last):
            text = "-"
            textList = GameText(text: text)
            textList.setAnimate(index: 0, eventType: eventType)
            break
        case .monster(.respawn):
            text = "テクテク…,\(self.getMonsterName())が現れた！"
            textList = GameText(text: text)
            guard let delegate = self.delegate else {
                textList.append(text: self.errorText)
                return textList
            }
            let player = delegate.getPlayer()
            let monster = delegate.getMonster()
            let monsterRation = monster.getRation()
            let playerLv = player.getLv()
            let ration = monsterRation - playerLv
            if ration <= 20 {
                textList.append(text: "弱そうだ！")
            }else if ration >= 80 {
                textList.append(text: "強そうだ…")
            }
            textList.append(text: "どうする？")
            textList.setAnimate(text: "\(self.getMonsterName())が現れた！", eventType: .animate(eventType))
            break
        case .monster(.attack):
            text = "\(self.getMonsterName()) は反撃してきた！,痛イッ！"
            guard let delegate = self.delegate else {
                text += ",\(self.errorText)"
                return GameText(text: text)
            }
            let player = delegate.getPlayer()
            if player.death {
                text += ",ばたっ…,\(self.getPlayerName())は力尽きた…"
            }else{
                text += ",\(self.getPlayerName())は逃げ出した…"
            }
            textList = GameText(text: text)
            textList.setAnimate(text: "ばたっ…", eventType: .animate(.player(.death)))
            textList.setAnimate(text: "\(self.getPlayerName())は逃げ出した…", eventType: .animate(.player(.escape)))
            break
        case .monster(.death):
            text = "\(self.getMonsterName())を倒した！,冒険者はレベルが上がった！"
            textList = GameText(text: text)
            textList.setAnimate(text: "\(self.getMonsterName())を倒した！", eventType: .animate(eventType))
            break
        case .player(.attack):
            text = "\(self.getPlayerName())が攻撃した！,ヤー！"
            textList = GameText(text: text)
            textList.setAnimate(index: 1, eventType: .animate(eventType))
            break
        case .player(.escape):
            text = "\(self.getPlayerName())は逃げ出した…"
            guard let delegate = self.delegate else {
                return GameText(text: text + ",\(self.errorText)")
            }
            let player = delegate.getPlayer()
            if player.death {
                text += ",\(self.getPlayerName())は走り疲れた,ばたっ…,\(self.getPlayerName())は力尽きた…"
            }
            textList = GameText(text: text)
            textList.setAnimate(text: "\(self.getPlayerName())は逃げ出した…", eventType: .animate(eventType))
            textList.setAnimate(text: "ばたっ…", eventType: .animate(.player(.death)))
            break
        case .player(.death):
            text = "\(self.getPlayerName())は力尽きた…,\(self.getPlayerName())は力尽きた…"
            textList = GameText(text: text)
            textList.setAnimate(index: 1, eventType: .system(.player(.death)))
            break
        default:
            text = self.errorText
            textList = GameText(text: text)
            break
        }
        return textList
    }
}
