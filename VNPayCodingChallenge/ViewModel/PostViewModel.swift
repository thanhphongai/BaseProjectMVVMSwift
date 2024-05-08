//
//  PostViewModel.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 08/05/2024.
//

import Foundation

protocol PostViewModelProtocol: ViewModelProtocol {

    var commentList: ObservableObject<[CommentModel]> { get set }
    
}

class PostViewModel: BaseViewModel {
    var commentList: ObservableObject<[CommentModel]> = ObservableObject<[CommentModel]>([])
    
    override init() {
        super.init()
        getCommentList()
    }
}

extension PostViewModel {
    private func getCommentList() {
        manager.callComment(.comment, .GET) { [weak self] res in
            switch res {
            case .success(let commentlist):
                self?.commentList.value = commentlist
            case.failure(let error):
                print("##Error CommentList \(error.localizedDescription)")
            }
        }
    }
}

extension PostViewModel:PostViewModelProtocol {
}
