//
//  LoremPicsumTableViewCell.swift
//  LoremPicsumProject
//
//  Created by Field Employee on 12/10/20.
//

import UIKit

class LoremPicsumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LoremPicSumImageView: UIImageView!
    
    @IBOutlet weak var LoremPicSumNameLabel: UILabel!
    
    func configure(with picsum: PicSum) {
        self.LoremPicSumNameLabel.text = picsum.id
        NetworkingManager.shared.getImageData(from: picsum.LoremImageURL) { (data, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.LoremPicSumImageView.image = UIImage(data:data)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
