//
//  ViewController.swift
//  catCrawler
//
//  Created by JunyeongChoi on 2022/07/16.
//

import UIKit

class ViewController: UIViewController, CatViewModelOutput {
    
    
    private enum Matrics {
        static let inset : CGFloat = 4
    }
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        layout.minimumLineSpacing = Matrics.inset
        layout.minimumInteritemSpacing = Matrics.inset
        return cv
    }()
    
    private let viewModel = CatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self.collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(CatCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        self.viewModel.delegate = self
        self.viewModel.load()
    }
    
    func loadComplete() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        
        let cellWidth = (width - 2 * Matrics.inset) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell" , for: indexPath) as! CatCell
        cell.backgroundColor = .black
        return cell
    }
    
    
}
