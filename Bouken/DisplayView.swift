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
    //@IBInspectable var text: String = ""
    
    let audio = Audio()

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
    
    func escapeAnimate(){
        self.audio.escape()
        self.textButton.isEnabled = false
        
        UIView.animate(withDuration: 0.4,  animations: {
            self.monsterImageView.center.x -= self.monsterImageView.bounds.width
            self.monsterImageView.alpha = 0
        }, completion: { _ in
            self.monsterImageView.center.x += self.monsterImageView.bounds.width
            self.animateCompletion(true)
        })
        
    }
    
    func respawnAnimate() {

//        self.textButton.isEnabled = false
        
        UIView.animate(withDuration: 0.4,  animations: {
            self.monsterImageView.alpha = 1
        }, completion:  self.animateCompletion(_:))
        
    }
    
    func playerAttackAnimate(){
        
        self.audio.playerAttack()
        self.textButton.isEnabled = false
        
        UIView.animate(withDuration: 0.1, animations: {
            self.monsterImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.monsterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion:  self.animateCompletion(_:))
        
    }
    
    func playerDeathAnimate(){
        
        self.textButton.isEnabled = false
        
        self.backImageView.addSubview(self.monsterImageView)
        UIView.animate(withDuration: 0.3, animations: {
            self.backImageView.transform = CGAffineTransformMakeRotation(.pi/2)
        }, completion:  self.animateCompletion(_:))
        
    }
    
    func monsterAttckAnimate(){
        
        self.textButton.isEnabled = false
        
        UIView.animate(withDuration: 0.1, animations: {
            self.monsterImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion:  self.animateCompletion(_:))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.monsterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
    }
    
    func monsterDeathAnimate(){
        
        self.textButton.isEnabled = false
        
        UIView.animate(withDuration: 1.0, animations: {
            self.monsterImageView.alpha = 0
        }, completion:  self.animateCompletion(_:))
        
    }
    
    func animateCompletion(_ bool:Bool){
        self.textButton.isEnabled = true
    }
}
