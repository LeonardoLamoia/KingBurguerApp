//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 09/11/23.
//

import UIKit

class WebServiceAPI {
    
    
    static let apiKey = "94310d82-fc87-44af-be84-ca2a37b27167"
    static let baseURL = "https://hades.tiagoaguiar.co/kingburguer"
    
    
    static let shared = WebServiceAPI()
    
    
    enum Endpoint: String {
        case createUser = "/users"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case feed = "/feed"
    }
    
    enum Method: String {
        case post
        case put
        case get
        case delete
    }
    
    enum NetworkError {
        case unauthorized
        case badRequest
        case notFound
        case internalError
        case unknown
    }
    
    enum Result {
        case success(Data?)
        case failure(NetworkError, Data?)
    }
    
    
    private func completeUrl(path: Endpoint) -> URLRequest? {
        let endpoint = "\(WebServiceAPI.baseURL)\(path.rawValue)"
        guard let url = URL(string: endpoint) else {
            print("ERROR: URL \(endpoint) malformed!")
            return nil
        }
        return URLRequest(url: url)
    }
    
    
    
    func call<R: Encodable>(path: Endpoint, body: R?, method: Method, accessToken: String? = nil, completion: @escaping (Result) -> Void) {
        
        
        do {
            
            guard var request = completeUrl(path: path) else { return }
            
            request.httpMethod = method.rawValue.uppercased();           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(WebServiceAPI.apiKey, forHTTPHeaderField: "x-secret-key")
            
            if let accessToken = accessToken {
                request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            if let body = body {
                let jsonRequest = try JSONEncoder().encode(body)
                request.httpBody = jsonRequest
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // assincrono
                print("Response is \(String(describing: response))")
                print("--------------------\n\n")
                
                if let error = error {
                    print(error)
                    completion(Result.failure(.internalError, data))
                    return
                }
                
                if let r = response as? HTTPURLResponse {
                    switch r.statusCode {
                    case 200:
                        completion(.success(data))
                    case 401:
                        completion(Result.failure(.unauthorized, data))
                        break
                    case 404:
                        completion(Result.failure(.notFound, data))
                        break
                    case 400:
                        completion(Result.failure(.badRequest, data))
                        break
                    case 500:
                        completion(Result.failure(.internalError, data))
                        break
                    default:
                        completion(Result.failure(.unknown, data))
                        break
                    }
                }
                
            }
            
            
            task.resume()
        }
        catch {
            print(error)
            return
        }
        
    }
}
