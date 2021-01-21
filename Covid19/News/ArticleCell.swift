//
//  ArticleCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import UIKit

class ArticleCell: UICollectionViewCell {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var authorLb: RoundedMediaSource!
    @IBOutlet weak var imageLb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        imageLb.image = nil
    }
    func setupArticle(item: Article, group: Int) {
        titleLb.text = item.title
        authorLb.text = "  " + (item.source.name ?? "") + "  "
        
        if let imgUrl = item.urlToImage {
            DispatchQueue.global(qos: .background).async {
                let img = ImageDownloader.downloadImageWithURL(url: imgUrl)
                DispatchQueue.main.async {
                    self.imageLb.image = img
                }
            }
        }
    }
}
