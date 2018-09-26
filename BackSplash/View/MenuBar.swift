//
//  MenuBar.swift
//  BackSplash
//
//  Created by Jigna Patel on 17.09.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    let cellMenuId = "menuCell"
    
    let arrMenuTitle = ["Latest","Popular","Oldest"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    var homeVC: HomeVC?

    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        backgroundColor = UIColor.white
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellMenuId)
        
        let selectedIndexpath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexpath, animated: false, scrollPosition: [])
        
    
        setUpHorizontalBar()
        
    }
    
    var horizontalViewLeftConstraint: NSLayoutConstraint?
    
    func setUpHorizontalBar()  {
        
        let horizontalView = UIView()
//        horizontalView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalView.backgroundColor = UIColor.black
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalView)
        
        
        horizontalViewLeftConstraint = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalViewLeftConstraint?.isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        addConstraintsWithFormat(format: "V:[v0(4)]|", views: horizontalView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMenuTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMenuId, for: indexPath) as! MenuCell
        cell.lblMenuTitle.text = arrMenuTitle[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeVC?.scrollToMenuIndex(index: indexPath.row)
    }
    
    
    class MenuCell: BaseCell {
    
        let lblMenuTitle: UILabel = {
            let label = UILabel()
            label.backgroundColor = UIColor.clear
            label.textColor = UIColor.gray
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            return label
        }()
        
        override var isHighlighted: Bool {
            didSet {
               
                lblMenuTitle.textColor = isHighlighted ? UIColor.black : UIColor.gray
            }
        }
        
        override var isSelected: Bool {
            didSet {
                
                lblMenuTitle.textColor = isSelected ? UIColor.black : UIColor.gray
            }
        }
        
        
        override func setUpViews() {
            super.setUpViews()
            
            addSubview(lblMenuTitle)
            addConstraintsWithFormat(format: "H:|[v0]|", views: lblMenuTitle)
            addConstraintsWithFormat(format: "V:|[v0]|", views: lblMenuTitle)

        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

