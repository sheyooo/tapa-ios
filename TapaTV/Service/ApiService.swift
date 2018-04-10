//
//  ApiService.swift
//  TapaTV
//
//  Created by SimpuMind on 3/25/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess

protocol JSONDecodable {
    init?(_ json: [String: Any])
}

public class ApiService: NSObject {
    
    static let shared = ApiService()
    
    var alamoFireManager : SessionManager?
    
    let savedUserKey = "savedUser"
    
    var user = User(id: "", updatedAt: "", createdAt: "", name: "", email: "", role: "", __v: 0, deleted: false, stripeSubscription: false, canWatch: false)
    
    func rememberUser(user: User){
        self.user = user
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: user)
        do {
            try
                Constant
                .keychain.set(archivedObject, key: "user")
        }catch let error {
            print("Did not save data \(error.localizedDescription)")
        }
    }
    
    func loadRememberedUser(){
        do {
            let data = try
                Constant
                    .keychain.getData("user")
            if let savedUser = NSKeyedUnarchiver.unarchiveObject(with: data!) as? User {
                user = savedUser
            }
        }catch let error {
             print("Error found \(error.localizedDescription)")
        }
    }
    
    func loginUser(with params: [String: String], completion: @escaping (Bool, String) -> ()){
        let urlString = Constant.BASE_URL + Constant.LOGIN
        let url = URL(string: urlString)!
        authentication(with: params, url: url, completion: completion)
    }
    
    func signUpUser(with params: [String: String], completion: @escaping (Bool, String) -> ()){
        let urlString = Constant.BASE_URL + Constant.SIGNUP
        let url = URL(string: urlString)!
        authentication(with: params, url: url, completion: completion)
    }

    fileprivate func authentication(with params: [String: String], url: URL, completion: @escaping (Bool, String) -> ()){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 40
        configuration.timeoutIntervalForResource = 40
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        alamoFireManager?.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    completion(false, "Network connection error, please retry!")
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    //print("Malformed data received from user service")
                    completion(false, "Malformed data received from user service")
                    return
                }
                
                print(value)
                
                if let error = value["error"] as? [String: Any], let message = error["message"] as? String {
                    completion(false, message)
                    return
                }
                
                guard let token = value["token"] as? String else {
                    completion(false, "User alredy exist!")
                    return
                }
                
                Constant.keychain["token"] = token
                
                guard let user = value["user"] as? [String: Any] else {
                    completion(false, "success")
                    return
                }
                
                print(user)
                
                guard let userData = User(user) else {
                    completion(false, "Unable to save user data")
                    return
                }
                print(userData.dictionaryRepresentation())
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.synchronize()
                ApiService.shared.rememberUser(user: userData)
                completion(true, "success")
        }
    }
    
    func fetchMovieList(completion: @escaping ([Movie]?, _ message: String) -> ()){
        
        let urlString = Constant.BASE_URL + "movies"
        let url = URL(string: urlString)!
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 40
        configuration.timeoutIntervalForResource = 40
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        alamoFireManager?.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
               
                guard response.result.isSuccess else {
                    completion(nil, "Network connection error!")
                    return
                }
                
                guard let value = response.result.value as? [[String: Any]] else {
                    //print("Malformed data received from user service")
                    completion(nil, "Network connection error!")
                    return
                }
                
                let movies = value.compactMap {return Movie($0)}
                
                DispatchQueue.main.async {
                    completion(movies, "success")
                }
        }
        
    }
    
}
