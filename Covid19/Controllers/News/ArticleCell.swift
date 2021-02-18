//
//  ArticleCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import UIKit

class ArticleCell: UICollectionViewCell {

    // Dependecies
    private let imageDownloader = Dependencies.container.resolve(ImageDownloader.self)!
    
    //Outlets
    @IBOutlet private weak var titleLb: UILabel!
    @IBOutlet private weak var authorLb: RoundedMediaSource!
    @IBOutlet private weak var imageLb: UIImageView!
    
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
                let img = self.imageDownloader.downloadImageWithURL(url: imgUrl)
                DispatchQueue.main.async {
                    self.imageLb.image = img
                }
            }
        }
    }
}
