//
//  HomeVC.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tbvPost: UITableView!
    
    var postList: [UserPostModel] = []
    var userList: [UserModel] = []
    var commentList: [CommentModel] = []
    private var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Posts"
        setupUI()
        setupData()
    }
    
}

extension HomeVC {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupData() {
        viewModel = HomeViewModel()
        
        viewModel.userList.bind { [weak self] res in
            DispatchQueue.main.async {
                guard let res = res else { return }
                self?.userList = res
                if (!res.isEmpty) {
                    self?.tbvPost.reloadData()
                }
            }
        }
        
        viewModel.postList.bind { [weak self] res in
            DispatchQueue.main.async {
                guard let res = res else { return }
                self?.postList = res
                self?.tbvPost.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tbvPost.delegate = self
        tbvPost.dataSource = self
        tbvPost.register(UINib(nibName: PostCell.identifier, bundle: nil), forCellReuseIdentifier: PostCell.identifier)
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < postList.count else {
            return UITableViewCell()
        }
        
        let post = postList[indexPath.item]
        
        guard post.userId - 1 < userList.count else {
            return UITableViewCell()
        }
        
        let user = userList[post.userId - 1]
        
        let viewModel = PostResponse.create(from: post, by: user)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
        cell.setupCell(with: viewModel, delegate: self)
        return cell
    }
}

extension HomeVC: PostCellDelegate {
    func showPostDetail(at postID: Int, by user: UserModel) {
        let postViewModel = PostResponse.create(from: postList[postID-1], by: user)
        viewModel.showPostDetail(self, viewModel:postViewModel)
    }
}
