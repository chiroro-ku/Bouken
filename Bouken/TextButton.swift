//
//  TextButton.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/26.
//

import Foundation
import UIKit

@IBDesignable
final class TextButton: Button {
    
    var delegate: TextButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textButtonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.textButtonInit()
    }
    
    private func textButtonInit(){
        if #available(iOS 15.0, *) {
            self.configuration = nil
        }
        self.titleLabel?.font = UIFont(name: "JF-Dot-k12x10", size: 20)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addTarget(self, action: #selector(textButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func textButtonTapped(_ sender: UIButton){
        guard let delegate = delegate, let text = delegate.nextText() else {
            return
        }
        self.setTitle(text, for: .normal)
    }

}
