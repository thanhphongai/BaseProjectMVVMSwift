//
//  HomeViewModel.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

protocol HomeViewModelProtocol: ViewModelProtocol {
    var postList: ObservableObject<[UserPostModel]> { get set }
    var userList: ObservableObject<[UserModel]> { get set }
    
    func showPostDetail(_ controller:HomeVC?, viewModel: PostResponse)
}

class HomeViewModel: BaseViewModel {
    var postList: ObservableObject<[UserPostModel]> = ObservableObject<[UserPostModel]>([])
    var userList: ObservableObject<[UserModel]> = ObservableObject<[UserModel]>([])
    
    override init() {
        super.init()
        
        fetchUserData()
    }
}

extension HomeViewModel {
    
    private func fetchUserData() {
        getUserList()
        getPostList()
    }

    private func getPostList(completion: @escaping (Bool) -> Void) {
        manager.callUserPost(.post, .GET) { [weak self] res in
            switch res {
            case .success(let postlist):
                self?.postList.value = postlist
                completion(true)
            case .failure(let error):
                print("##Error PostList \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    private func getUserList(completion: @escaping (Bool) -> Void) {
        manager.callUser(.user, .GET) { [weak self] res in
            switch res {
            case .success(let userlist):
                self?.userList.value = userlist
                completion(true)
            case .failure(let error):
                print("##Error UserList \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    
    private func getPostList() {
        manager.callUserPost(.post, .GET) { [weak self] res in
            switch res {
            case .success(let postlist):
                self?.postList.value = postlist
            case.failure(let error):
                print("##Error PostList \(error.localizedDescription)")
            }
        }
    }
    
    private func getUserList() {
        manager.callUser(.user, .GET) { [weak self] res in
            switch res {
            case .success(let userlist):
                self?.userList.value = userlist
            case.failure(let error):
                print("##Error UserList \(error.localizedDescription)")
            }
        }
    }
    

}

extension HomeViewModel:HomeViewModelProtocol {
    public func showPostDetail(_ controller: HomeVC?, viewModel: PostResponse) {
        let postVC = PostVC(postViewModel: viewModel)
        postVC.modalTransitionStyle = .crossDissolve
        controller?.present(postVC, animated: true, completion: nil)
    }
}


