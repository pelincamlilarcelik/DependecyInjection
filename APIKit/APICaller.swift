//
//  APICaller.swift
//  APIKit
//
//  Created by Onur Celik on 5.04.2023.
//

import Foundation
public class APICaller{
    public static let shared = APICaller()
    private init(){}
    
    public func fetchCoursesName(completion: @escaping ([String])->Void){
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else{
            completion([])
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                completion([])
                return
            }
            do{
                guard let json = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed) as? [[String:String]] else{
                    return
                }
                let courses = json.compactMap({$0["name"]})
                completion(courses)
            }catch{
                completion([])
                print(error.localizedDescription)
            }
        }.resume()
    }
}
