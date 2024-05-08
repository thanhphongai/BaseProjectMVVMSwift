//
//  PostVC.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import UIKit

class PostVC: UIViewController {
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var clvComment: UICollectionView!
    
    let postViewModel: PostResponse
    private var commentList: [CommentModel] = []
    private var viewModel: PostViewModelProtocol!
    
    init(postViewModel: PostResponse) {
        print(postViewModel)
        self.postViewModel = postViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
}

extension PostVC {
    private func setupUI() {
        setupCollectionView()
        lbTitle.text = "* Title: \(postViewModel.title)"
        lbUsername.text = "\(postViewModel.username) from \(postViewModel.companyName)"
        lbContent.text = "* Content : \(postViewModel.content)" 
    }
    
    private func setupData() {
        viewModel = PostViewModel()
        
        viewModel.commentList.bind { [weak self] res in
            DispatchQueue.main.async {
                guard let res = res else { return }
                self?.commentList = res.filter { $0.postId == self?.postViewModel.postID }
                if (!res.isEmpty) {
                    self?.clvComment.reloadData()
                }
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = clvComment.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
        clvComment.delegate = self
        clvComment.dataSource = self
        clvComment.register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellWithReuseIdentifier: CommentCell.identifier)
    }
}

extension PostVC: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.setupCell(name: commentList[indexPath.row].name, content: commentList[indexPath.row].body)
        return cell
    }
}

extension PostVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let content = commentList[indexPath.item].body
        return CommentCell.getCellSize(content: content)
    }
}
