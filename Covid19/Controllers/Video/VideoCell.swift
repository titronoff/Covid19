//
//  VideoCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/22/20.
//

import UIKit

class VideoCell: UICollectionViewCell {


    @IBOutlet weak var imageLb: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    @IBOutlet weak var mediaSource: RoundedMediaSource!
    @IBOutlet weak var tittleBackView: UIView!{
        didSet{
            tittleBackView.layer.cornerRadius = 10
            tittleBackView.layer.borderColor = UIColor.white.cgColor
            tittleBackView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var widthNSC: NSLayoutConstraint!
    @IBOutlet weak var heightNSC: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthNSC.constant = UIScreen.main.bounds.width
        heightNSC.constant = ceil(UIScreen.main.bounds.width * 0.5625)
    }
    func setupCell(item: Video){
//        guard let htmlString = item.snippet.title.data(using: .unicode) else { return }

//        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
//                        .documentType: NSAttributedString.DocumentType.html
//                     ]
//        let attributedHTMLString = try! NSAttributedString(data: htmlString, options: options, documentAttributes: nil)
        
        titleLb.text = item.snippet.title
        descriptionLb.text = item.snippet.description
        mediaSource.text = "  " + item.snippet.channelTitle + "  "
        let imgUrl = item.snippet.thumbnails.medium.url
        DispatchQueue.global(qos: .background).async {
            let img = ImageDownloader.downloadImageWithURL(url: imgUrl)
            DispatchQueue.main.async {
                self.imageLb.image = img
            }
        }
    }
}
