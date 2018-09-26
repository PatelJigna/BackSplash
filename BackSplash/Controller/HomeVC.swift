//
//  BSHomeVC.swift
//  BackSplash
//
//  Created by Jigna Patel on 20.06.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit
import UnsplashSwift
import SDWebImage
import AlertBar


protocol DetailVCDelegate: class {
    func goToDetailVC(photo:Photo)
}

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,DetailVCDelegate {
    
    let reuseIdentifier = "cellId"
    let popularCellId = "popularCellId"
    let oldestCellId = "oldestCellId"
    
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeVC = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    
    lazy var colViewImages: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        return cv
    }()
   
    var mainViewYPositionConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white

        self.view.addSubview(mainView)
        self.setMenuBar()
        self.setCollectionView()
        
        
        mainView.frame = CGRect(x: 0, y:  self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: self.mainView)

            self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: self.mainView)
            
            self.mainView.frame = self.view.bounds
            
        }, completion: nil)
    }
    
    
    func setCollectionView() {
        mainView.addSubview(colViewImages)
        
        mainView.addConstraintsWithFormat(format: "H:|[v0]|", views: colViewImages)
         colViewImages.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        mainView.addConstraintsWithFormat(format: "V:[v0]|", views: colViewImages)
        
        colViewImages.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        colViewImages.register(PopularCell.self, forCellWithReuseIdentifier: popularCellId)
        colViewImages.register(OldestCell.self, forCellWithReuseIdentifier: oldestCellId)
    
        if let flowLayout = colViewImages.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    
        colViewImages.isPagingEnabled = true
        
    }
    
    func setMenuBar()  {
      
        mainView.addSubview(menuBar)

        mainView.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        mainView.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    
    //MARK: - UICollectionview Datasource Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 1 {
          
            let cellPopular = collectionView.dequeueReusableCell(withReuseIdentifier: popularCellId, for: indexPath) as! PopularCell
            cellPopular.delegate = self
            return cellPopular
            
        }
        else if indexPath.row == 2 {
           
            let cellOldest = collectionView.dequeueReusableCell(withReuseIdentifier: oldestCellId, for: indexPath) as! OldestCell
            cellOldest.delegate = self
            return cellOldest
           
        }
        else {
          
           let cellLatest = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
            cellLatest.delegate = self
            return cellLatest
           
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalViewLeftConstraint?.constant = scrollView.contentOffset.x/3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        print(targetContentOffset.pointee.x)
        print(targetContentOffset.pointee.x/view.frame.width)
        
        let index:Int = Int(targetContentOffset.pointee.x/view.frame.width)
        let indexpath = IndexPath(item: index, section: 0)
        
        menuBar.collectionView.selectItem(at: indexpath, animated: true, scrollPosition: [])
        
    }
    
    func scrollToMenuIndex(index:Int)  {
        let selectedIndexPath = IndexPath(item:index , section: 0)
        colViewImages.scrollToItem(at: selectedIndexPath, at: [], animated: true)
    }
    
    
    func goToDetailVC(photo:Photo) {

        let detailVC = DetailVC()
        detailVC.selectedPhoto = photo
       self.navigationController?.pushViewController(detailVC, animated: true)
    
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
