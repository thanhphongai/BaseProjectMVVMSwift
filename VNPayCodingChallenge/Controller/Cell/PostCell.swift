//
//  PostCell.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import UIKit
protocol PostCellDelegate: AnyObject {
    func showPostDetail(at postID: Int, by user: UserModel)
}

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    
    weak var delegate: PostCellDelegate?
    
    private var postID: Int?
    private var user: UserModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(with item: PostResponse, delegate: PostCellDelegate) {
        self.delegate = delegate
        
        lbTitle.text = "* Title : \(item.title)"
        lbUsername.text = "-> \(item.username) from \(item.companyName)"
        lbBody.text = "* Content : \(item.content)"
        postID = item.postID
        user = item.user
    }
    
    @IBAction func postIsClicked(_ sender: UIButton) {
        guard let postID = self.postID,
              let user = self.user
        else { return }
        delegate?.showPostDetail(at: postID, by: user)
    }
}
