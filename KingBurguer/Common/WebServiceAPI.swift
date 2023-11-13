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
    }
    
    
    private func completeUrl(path: Endpoint) -> URLRequest? {
        let endpoint = "\(WebServiceAPI.baseURL)\(path.rawValue)"
        guard let url = URL(string: endpoint) else {
            print("ERROR: URL \(endpoint) malformed!")
            return nil
        }
        return URLRequest(url: url)
    }
    
    
    func createUser(request: SignUpRequest) {
        call(path: .createUser, body: request) { res in
            print(res)
        }
    }
    
    
    func call<R: Encodable>(path: Endpoint, body: R, completion: @escaping (String) -> Void) {
        
      
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
                    completion("ERROR \(error)")
                    return
                }
                
                guard let data = data else {
                    completion("No data found!")
                    return
                }
                
                
                if let d = String(data: data, encoding: .utf8) {
                    print("Data is \(d)")
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
