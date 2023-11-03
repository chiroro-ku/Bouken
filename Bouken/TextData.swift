//
//  TextData.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/27.
//

import Foundation

class TextData {
    
    var delegate: EventProtocol?
    
    private func getPlayerName() -> String {
        guard let delegate = self.delegate else {
            return "冒険者"
        }
        return delegate.getPlayerName()
    }
    
    private func getMonsterName() -> String {
        guard let delegate = self.delegate else {
            return "コウモリ"
        }
        return delegate.getMonsterName()
    }
    
    private func toTextList(text: String) -> [String]{
        let textList = text.components(separatedBy: ",")
        return textList
    }
    
    func getFirstTextList() -> [String] {
        let text = "ここをタップ！,冒険に行くぞ！,強そうなモンスターは,危険だから逃げよう！"
        let textList = self.toTextList(text: text)
        return textList
    }
    
    func getMonsterRespawnTextList() -> [String] {
        let text = "テクテク…,\(self.getMonsterName()) が現れた！,とても弱そうだ,どうする？"
        let textList = self.toTextList(text: text)
        return textList
    }
    
    func getMonsterDeathTextList() -> [String] {
        let text = "\(self.getMonsterName()) を倒した！,冒険者はレベルが上がった！"
        let textList = self.toTextList(text: text)
        return textList
    }
    
    func getMonsterAttackTextList() -> [String] {
        let text = "\(self.getMonsterName()) は反撃してきた！,痛イッ！,\(self.getPlayerName()) は逃げ出した…"
        let textList = self.toTextList(text: text)
        return textList
    }
    
    func getPlayerDeath() -> [String] {
        let text = "\(self.getPlayerName()) は力尽きた…"
        let textList = self.toTextList(text: text)
        return textList
    }
    
    func getAttackTextList() -> [String] {
        let text = "\(self.getPlayerName()) が攻撃した！,ヤー！"
        let textList = self.toTextList(text: text)
        return textList
    }
    
    func getEscapeTextList() -> [String] {
        let text = "\(self.getPlayerName()) は逃げ出した…"
        let textList = self.toTextList(text: text)
        return textList
    }
}
