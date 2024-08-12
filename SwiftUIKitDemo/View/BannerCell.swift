//
//  BannerCell.swift
//  SwiftUIKitDemo
//
//  Created by SIDDHARTH KOSHIYAR on 12/08/24.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    // MARK: - 📣 Outlets
    @IBOutlet weak var img: UIImageView!
    
    var data: CarouselModel? {
        didSet {
            setDataForItem()
        }
    }

    // MARK: - ✅ Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    /// Configure UI
    func configUI() {

    }
    
    func setDataForItem(){
        guard let data = data, !data.imageName.isEmpty else {
            return
        }
        img.image = UIImage(named: data.imageName)
    }
    
}
