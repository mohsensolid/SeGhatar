//
//  OptionsItemCollectionViewController.swift
//  SeGhatar
//
//  Created by MAC on 7/26/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
struct optionItem {
    var imageName:String
    var title:String
}
protocol optionProtocol {
    func itemClicked(title:String)
}
class OptionsItems: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var delegate:optionProtocol?
    
    let items:[optionItem]=[optionItem(imageName: "replay", title: gameOptionsString.reset),optionItem(imageName: "assistant", title: gameOptionsString.bot),optionItem(imageName: "online-game", title: gameOptionsString.online),optionItem(imageName: "teamwork", title: gameOptionsString.twoPlayer)]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemClicked(title: items[indexPath.row].title)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:CGFloat(frame.width/CGFloat(items.count)), height: CGFloat(frame.height))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! optionItemCell
        cell.wrappedItem = items[indexPath.row]
        return cell
    }
    
    lazy var cv :UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.alwaysBounceHorizontal = true
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    convenience init(delegate:optionProtocol){
        self.init(frame:.zero)
        self.delegate = delegate
        setupView()
    }
    func setupView(){
        addSubview(cv)
        
        NSLayoutConstraint.activate([cv.topAnchor.constraint(equalTo: topAnchor),cv.rightAnchor.constraint(equalTo: rightAnchor),cv.leftAnchor.constraint(equalTo: leftAnchor),cv.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        cv.register(optionItemCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class optionItemCell: UICollectionViewCell {
    
    override var isHighlighted: Bool{
        didSet{
            if self.isHighlighted{
                self.backgroundColor = UIColor(white: 0.70, alpha: 0.2)
            }else{
                self.backgroundColor=UIColor.white
            }
        }
    }
    var wrappedItem:optionItem?{
        didSet{
            guard let item = wrappedItem else{return}
            optionImage.image = UIImage(named: item.imageName)
            optionTitle.text = item.title
        }
    }
    let margin:CGFloat = 10
    let imageSize:CGFloat = 55
    let optionImage:UIImageView={
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let optionTitle:UILabel  = {
        let label = UILabel()
        label.font = UIFont(name: fonts.iranSans, size: fonts.large)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    func setupView(){
        addSubview(optionImage)
        addSubview(optionTitle)
        NSLayoutConstraint.activate([optionImage.topAnchor.constraint(equalTo: topAnchor, constant: margin),optionImage.widthAnchor.constraint(equalToConstant: imageSize),optionImage.heightAnchor.constraint(equalToConstant: imageSize),optionImage.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
        NSLayoutConstraint.activate([optionTitle.topAnchor.constraint(equalTo: optionImage.bottomAnchor, constant: margin),optionTitle.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
