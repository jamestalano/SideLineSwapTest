//
//  ProductCollectionCell.swift
//  SideLineSwapTest
//
//  Created by Mobile on 4/20/21.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    
    var bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(imageLiteralResourceName: "default")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // Create a UILabel of Current Value
    var titleText : UILabel = {
        let il = UILabel()
        il.translatesAutoresizingMaskIntoConstraints = false
        il.contentMode = .scaleAspectFill
        il.text = "Title"
        il.font = UIFont(name: "AvenirNext-DemiBold", size: 12.0)
        il.textColor = UIColor(rgb: 0x4A4A4A)
        return il
    }()
    
    // Create a UILabel of name.
    var sellerName : UILabel = {
        let il = UILabel()
        il.translatesAutoresizingMaskIntoConstraints = false
        il.contentMode = .scaleAspectFill
        il.text = "SellerName111"
        il.font = UIFont(name: "AvenirNext-Regular", size: 11.0)
        il.textColor = UIColor(rgb: 0x4A4A4A)
        return il
    }()
    
    var priceText : UILabel = {
        let il = UILabel()
        il.translatesAutoresizingMaskIntoConstraints = false
        il.contentMode = .scaleAspectFill
        il.text = "$110"
        il.font = UIFont(name: "AvenirNext-Regular", size: 11.0)
        il.textColor = UIColor(rgb: 0x4A4A4A)
        return il
    }()
    
    
    override func prepareForReuse () {
      super.prepareForReuse ()
        sellerName.text = ""
        priceText.text = ""
        titleText.text = ""
        
        // Cancel Current Image Load to avoid wrong image showed in the cell
        bg.sd_cancelCurrentImageLoad ()
    }
    override init(frame: CGRect){
        super.init(frame: .zero)

        // Add subviews.
        contentView.addSubview(bg)
        contentView.addSubview(titleText)
        contentView.addSubview(priceText)
        contentView.addSubview(sellerName)
        
        
        let width = frame.size.width
        // Set the constraint of thumbnail image.

        NSLayoutConstraint.activate([
            bg.heightAnchor.constraint(equalToConstant: width),
            bg.widthAnchor.constraint(equalToConstant: width),
            bg.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            bg.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            
        ])
        
        // Set the constraint of offer label.

        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: bg.bottomAnchor, constant: 5),
            titleText.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleText.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
        
        // Set the constraint of name label.

        NSLayoutConstraint.activate([
            priceText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 3),
            priceText.leftAnchor.constraint(equalTo: self.leftAnchor),
            priceText.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            sellerName.topAnchor.constraint(equalTo: priceText.bottomAnchor, constant: 3),
        sellerName.leftAnchor.constraint(equalTo: self.leftAnchor),
        sellerName.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented!")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
