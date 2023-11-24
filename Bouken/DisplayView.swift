//
//  DisplayView.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/25.
//

import UIKit

@IBDesignable
final class DisplayView: UIView {
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var textButton: TextButton!
//    @IBInspectable var text: String = ""
    
    let audio = Audio()
    
    var delegete: DisplayViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.monsterImageView.alpha = 0
        //self.textButton.titleLabel?.text = self.text
    }

    private func loadNib() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed("DisplayView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = bounds
        addSubview(view)
    }
    
    func playerDeathAnimate(){
        self.textButton.isEnabled = false
        
        self.backImageView.addSubview(self.monsterImageView)
        UIView.animate(withDuration: 0.3, animations: {
            self.backImageView.transform = CGAffineTransformMakeRotation(.pi/2)
        }, completion:  self.animateCompletion(_:))
    }
    
    func monsterRespawnAnimate() {
        UIView.animate(withDuration: 0.4,  animations: {
            self.monsterImageView.alpha = 1
        })
    }
    
    func monsterDeathAnimate(){
        self.textButton.isEnabled = false
        self.audio.playerAttack()
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.monsterImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.66, animations: {
                self.monsterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion: { _ in
            
            // 改修予定
            UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                self.monsterImageView.alpha = 0.3
            }, completion: { _ in
                self.audio.monsterDeath()
                UIView.animate(withDuration: 0.7, animations: {
                    self.monsterImageView.alpha = 0
                }, completion: { _ in
                    self.animateCompletion(true)
                })
            })
        })
    }
    
    func monsterAttackAnimate(){
        self.textButton.isEnabled = false
        self.audio.playerAttack()
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                self.monsterImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.66, animations: {
                self.monsterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion: { _ in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.5, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                    self.monsterImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.66, animations: {
                    self.monsterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }, completion: { _ in
                self.audio.monsterAttack()
                UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
                    self.monsterImageView.center.x -= self.monsterImageView.bounds.width
                    self.monsterImageView.alpha = 0
                }, completion: { _ in
                    self.audio.playerEscape()
                    self.monsterImageView.center.x += self.monsterImageView.bounds.width
                    guard let delegete = self.delegete else{
                        return
                    }
                    delegete.load()
                    self.animateCompletion(true)
                })
            })
        })
    }
    
    func playerEscapeAnimate(){
        self.textButton.isEnabled = false
        
        UIView.animate(withDuration: 0.4, animations: {
            self.monsterImageView.center.x -= self.monsterImageView.bounds.width
            self.monsterImageView.alpha = 0
        }, completion: { _ in
            self.audio.playerEscape()
            self.monsterImageView.center.x += self.monsterImageView.bounds.width
            guard let delegete = self.delegete else{
                return
            }
            delegete.load()
            self.animateCompletion(true)
        })
    }
    
    func animateCompletion(_ bool:Bool){
        self.textButton.isEnabled = true
    }
}
