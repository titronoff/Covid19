//
//  VideoCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/22/20.
//

import UIKit

class VideoCell: UICollectionViewCell {

    // Dependecies
    private let imageDownloader = Dependencies.container.resolve(ImageDownloader.self)!
    
    //Outlets
    @IBOutlet private weak var imageLb: UIImageView!
    @IBOutlet private weak var titleLb: UILabel!
    @IBOutlet private weak var descriptionLb: UILabel!
    @IBOutlet private weak var mediaSource: RoundedMediaSource!
    @IBOutlet private weak var tittleBackView: UIView!{
        didSet{
            tittleBackView.layer.cornerRadius = 10
            tittleBackView.layer.borderColor = UIColor.white.cgColor
            tittleBackView.layer.borderWidth = 1
        }
    }
    @IBOutlet private weak var widthNSC: NSLayoutConstraint!
    @IBOutlet private weak var heightNSC: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthNSC.constant = UIScreen.main.bounds.width
        heightNSC.constant = ceil(UIScreen.main.bounds.width * 0.5625)
    }
    func setupCell(item: Video){
        
        titleLb.text = item.snippet.title
        descriptionLb.text = item.snippet.description
        mediaSource.text = "  " + item.snippet.channelTitle + "  "
        let imgUrl = item.snippet.thumbnails.medium.url
        DispatchQueue.global(qos: .background).async {
            let img = self.imageDownloader.downloadImageWithURL(url: imgUrl)
            DispatchQueue.main.async {
                self.imageLb.image = img
            }
        }
    }
}
