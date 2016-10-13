//
//  RestApiManager.swift
//  sep1
//
//  Created by Richard de Jongh on 22/09/16.
//  Copyright © 2016 Richard de Jongh. All rights reserved.
//

import UIKit
import Alamofire

class RestApiManager: NSObject {
    
    // Make it singleton
    static let sharedInstance = RestApiManager()
    
        let url : String = "https://randomuser.me/api/"
    
    
    func getRestPerson(tableview:UITableView) -> Person {
        let person = Person()
       
        //var personemail = ""
        Alamofire.request(url,
                          method: .get,
                          encoding: URLEncoding.default).responseJSON { response in
                            if let json = response.result.value as? Dictionary<String, Any>{
//                                print("json: \(json)")
                                for field in json["results"] as? [AnyObject] ?? []{
                                    //Gender
                                    if let gender = field["gender"] as? String {
                                        print(gender)
                                        
                                    }
                                    //Full name
                                    if let fullName = field["name"] as? [String : AnyObject]{
                                        //Title
                                        if let title = fullName["title"] as? String{
                                            print(title)
                                        }
                                        //First name
                                        if let firstName = fullName["first"] as? String{
                                            print(firstName);
                                            person.firstName = firstName;
                                        }
                                        //Last name
                                        if let lastName = fullName["last"] as? String{
                                            person.lastName = lastName;
                                            print(lastName);
                                            
                                        }
                                    }
                                    //Email
                                    if let email = field["email"] as? String{
                                        print(email);
                                        person.email = email;
                                    }

                                    }
                                }
                            }
    
        return person
}
}

