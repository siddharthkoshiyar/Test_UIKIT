//
//  DataListCell.swift
//  SwiftUIKitDemo
//
//  Created by SIDDHARTH KOSHIYAR on 10/08/24.
//

import UIKit

class DataListCell: UITableViewCell, NibReusable {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descrlbl: UILabel!
    var data: ListModel? {
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
        imgView.image = UIImage(named: data.imageName)
        title.text = data.titleText
        descrlbl.text = data.subtitleText
    }
    
    
}
