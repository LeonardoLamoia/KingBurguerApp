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
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void) {
        call(path: .login, body: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
                
            case .failure(let error, let data):
                print("ERROR: \(error)")
                
                guard let data = data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                default:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
                break
            }
        }
    }
    
    
    func call<R: Encodable>(path: Endpoint, body: R, completion: @escaping (Result) -> Void) {
        
        
        do {
            let jsonRequest = try JSONEncoder().encode(body)
            
            
            guard var request = completeUrl(path: path) else { return }
            
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(WebServiceAPI.apiKey, forHTTPHeaderField: "x-secret-key")
            
            
            request.httpBody = jsonRequest
            
            
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
