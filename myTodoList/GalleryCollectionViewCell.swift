//
//  GalleryCollectionViewCell.swift
//  myTodoList
//
//  Created by 홍희곤 on 2/1/24.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    let cellImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "gallery"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let iview: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(iview)
        
        addSubview(cellImage)
        setUI()
    }
}

extension GalleryCollectionViewCell {
    func setUI() {
        iview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iview.topAnchor.constraint(equalTo: self.topAnchor),
            iview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iview.rightAnchor.constraint(equalTo: self.rightAnchor),
            iview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
