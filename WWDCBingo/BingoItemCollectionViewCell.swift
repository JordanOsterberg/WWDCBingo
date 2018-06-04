//
//  BingoItemCollectionViewCell.swift
//  WWDCBingo
//
//  Created by Jordan Osterberg on 6/3/18.
//  Copyright © 2018 Jordan Osterberg. All rights reserved.
//

import UIKit

class BingoItemCollectionViewCell : UICollectionViewCell {
    
    let emojiLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "📱"
        return label
    }()
    
    var item : BingoItem? = nil {
        didSet {
            self.emojiLabel.text = item?.emoji
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        
        self.contentView.addSubview(self.emojiLabel)
        
        self.emojiLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.emojiLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.emojiLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateState() {
        if item?.selected == true {
            self.backgroundColor = UIColor.green
        } else {
            self.backgroundColor = UIColor.green.withAlphaComponent(0.7)
        }
    }
    
}
