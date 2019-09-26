//
//  BookmarkCollectionViewCell.swift
//  movie-core-data
//
//  Created by Htet Arkar Zaw on 9/26/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit
import SDWebImage
class BookmarkCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    
    var data : MovieVO? {
        didSet {
            if let data = data {
                movieImage.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(data.poster_path ?? "")"), completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var identifier : String {
        return String(describing: self)
    }
}
