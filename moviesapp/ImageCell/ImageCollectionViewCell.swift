//
//  ImageCollectionViewCell.swift
//  moviesapp
//
//  Created by Jayasri Gandi on 25/04/25.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUI(content:Content?){
        image.backgroundColor = UIColor.red
        
        guard let  url = URL(string: content?.imagery?.featuredImg ?? "") else {return}
        image.sd_setImage(with: url,placeholderImage: UIImage(named: ""))
        
    }

}
