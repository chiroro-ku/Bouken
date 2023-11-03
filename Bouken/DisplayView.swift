//
//  DisplayView.swift
//  Bouken
//
//  Created by 小林千浩 on 2023/10/25.
//

import UIKit

@IBDesignable
final class DisplayView: UIView {
    
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var textButton: TextButton!
    //@IBInspectable var text: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //self.textButton.titleLabel?.text = self.text
    }

    private func loadNib() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed("DisplayView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = bounds
        addSubview(view)
    }
}
