//
//  ViewController.swift
//  WWDCBingo
//
//  Created by Jordan Osterberg on 6/3/18.
//  Copyright © 2018 Jordan Osterberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(3)
        layout.minimumInteritemSpacing = CGFloat(1)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return collectionView
    }()
    
    var sheet : BingoSheet? = nil
    let bingoItemCellIdentifier = "bingoItemCell"
    
    override func viewDidLoad() {
        self.navigationItem.title = "Bingo"
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        }
        
        self.view.backgroundColor = UIColor.white
        
        self.layoutSubviews()
        
        self.collectionView.register(BingoItemCollectionViewCell.self, forCellWithReuseIdentifier: bingoItemCellIdentifier)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.newSheet()
    }
    
    func layoutSubviews() {
        self.view.addSubview(self.collectionView)
        
        self.collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -10).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.collectionView.widthAnchor, constant: 5).isActive = true
    }

    func newSheet() {
        self.sheet = BingoSheet()
        self.sheet?.squares = []
        
        for _ in 0...24 {
            self.sheet?.squares.append(BingoItem(text: "Test", emoji: "🤟🏻", selected: false))
        }
    }
    

}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sheet?.squares.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bingoItemCellIdentifier, for: indexPath) as! BingoItemCollectionViewCell
        cell.item = self.sheet?.squares[indexPath.row]
        return cell
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let unit = (collectionView.frame.width / 5) - 2
        return CGSize(width: unit, height: unit)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var item = self.sheet?.squares[indexPath.row] else {
            return
        }
        
        item.selected = !item.selected
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BingoItemCollectionViewCell {
            cell.updateState()
        }
    }
    
}






