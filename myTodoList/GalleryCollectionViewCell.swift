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
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 셀에 이미지 뷰 추가
        addSubview(cellImage)
        cellImage.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
