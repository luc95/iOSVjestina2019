//
//  QuizzesTableSectionHeader.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

import UIKit

class QuizzesTableSectionHeader: UIView {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        backgroundColor = color

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
