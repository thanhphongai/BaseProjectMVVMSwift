//
//  NetworkManager.swift
//  VNPayCodingChallenge
//
//  Created by macbookpro on 07/05/2024.
//

import Foundation

final class NetworkManager {
    private static var networkManager: NetworkManager!
    
    let baseURL = Handler.configuration(.WebURL)
    
    static func share() -> NetworkManager {
        if(networkManager == nil) {
            networkManager = NetworkManager()
        }
        
        return networkManager
    }
}

extension NetworkManager {
    
    // MARK: - Create Request
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void){
        
        guard let apiURL = url else {
            return
        }
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
    
    // MARK: - JSON Parser
    public func callUser(_ request: Path, _ type: HTTPMethod, completion: @escaping(Result<[UserModel], Error>) -> Void) {
        createRequest(with: URL(string: baseURL + "\(request.rawValue)"), type: type) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error  == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([UserModel].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    public func callUserPost(_ request: Path, _ type: HTTPMethod, completion: @escaping(Result<[UserPostModel], Error>) -> Void) {
        createRequest(with: URL(string: baseURL + "\(request.rawValue)"), type: type) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error  == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([UserPostModel].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    public func callComment(_ request: Path, _ type: HTTPMethod, completion: @escaping(Result<[CommentModel], Error>) -> Void) {
        createRequest(with: URL(string: baseURL + "\(request.rawValue)"), type: type) {
            baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error  == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([CommentModel].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
}





