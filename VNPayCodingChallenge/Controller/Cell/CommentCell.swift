//
//  CommentCell.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 08/05/2024.
//

import UIKit

class CommentCell: UICollectionViewCell {
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    static let identifier = "CommentCell"
    static func getCellSize(content: String) -> CGSize {
        let cellWidth: CGFloat = UIScreen.main.bounds.width
        let baseHeight: CGFloat = 56.0
        let contentArr = content.split(separator: "\n")
        var contentHeight: CGFloat = 0.0
        
        for str in contentArr {
            let strHeight: CGFloat = String(str).calculateHeight(with: cellWidth-32.0, font: .systemFont(ofSize: 16.0))
            contentHeight += strHeight
        }
        
        let calculatedContentHeight: CGFloat = contentHeight > 20.0 ? contentHeight : 20.0
        let cellHeight: CGFloat = baseHeight + calculatedContentHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(name: String, content: String) {
        lbUserName.text = "* Name : \(name)"
        lbContent.text = "* Comment : \(content)"
    }
}
