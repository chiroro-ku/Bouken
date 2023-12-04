//
//  TextData.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/11/21.
//

import Foundation

class TextData{
    
    var model: Model = Model()
    
    private func getMonsterName() -> String{
        guard let name = self.model.monster?.name else{
            return "-"
        }
        return " \(name) "
    }
    
    private func getPlayerName() -> String{
        return " \(self.model.player.name) "
    }
    
    func getText(event: EventType) -> String{
        var text = ""
        switch event{
        case .system(.first):
            text = "ここをタップ！,冒険に行くぞ！,強そうなモンスターは,怖いから逃げよう！"
            break
        case .player(.walk):
            text = "テクテク…"
            break
        case .player(.attack):
            guard let monster = self.model.monster else{
                return "-"
            }
            if monster.death{
                text = "\(self.getPlayerName())は攻撃した！,\(self.getMonsterName())を倒した！"
            }else if self.model.player.death{
                text = "\(self.getPlayerName())は攻撃した！,\(self.getMonsterName())は反撃してきた！, \(monster.damege) ダメージを受けた…"
            } else {
                text = "\(self.getPlayerName())は攻撃した！,\(self.getMonsterName())は反撃してきた！,\(monster.damege) ダメージを受けた,\(self.getPlayerName())は逃げ出した…"
            }
            break
        case .player(.escape):
            if self.model.player.death{
                text = "\(self.getPlayerName())は逃げ出した…,走り疲れた…"
            }else{
                text = "\(self.getPlayerName())は逃げ出した…"
            }
            break
        case .player(.levelUP):
            text = "\(self.getPlayerName())はレベルアップした！"
            break
        case .player(.death):
            text = "ばた…,\(self.getPlayerName())は力尽きた…"
            break
        case .monster(.respawn):
            text = "\(self.getMonsterName())が現れた！,"
            if let textData = self.model.monster?.text, textData != "_" {
                let textDatas = textData.components(separatedBy: "-")
                for aText in textDatas {
                    if aText == "Name" {
                        text += self.getMonsterName()
                    }else{
                        text += aText + ","
                    }
                }
            }
            text += "どうする?"
            break
        case .monster(.event):
            guard let monster = self.model.monster else{
                return "-"
            }
            let eventName = monster.event
            switch eventName{
            case "食べる":
                text = "\(self.getMonsterName())は大きく口を開けた…！,攻撃しようと近づいた\(self.getPlayerName())は、,\(self.getMonsterName())に飲み込まれた！"
                break
            case "魔法":
                guard let damege = self.model.monster?.eventValue else{
                    return "-"
                }
                text = "\(self.getMonsterName())に魔法で攻撃された！,\(damege)ダメージ！"
                break
            case "俊敏":
                guard let damege = self.model.monster?.eventValue else{
                    return "-"
                }
                text = "\(self.getMonsterName())は追いかけてきた！,\(damege)ダメージ！"
                break
            default:
                break
            }
        default:
            break
        }
        return text
    }
}
