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
        let database = DataBaseHelper.sharedInstance
    
    func getRestPerson(onCompletion: @escaping (Person?) -> Void) {
        let person = Person()
       
        //var personemail = ""
        Alamofire.request(url,
                          method: .get,
                          encoding: URLEncoding.default).responseJSON { response in
                            if let json = response.result.value as? Dictionary<String, Any>{
                                //                                print("json: \(json)")
                                for field in json["results"] as? [AnyObject] ?? []{
                                    
                                    //Full name
                                    if let fullName = field["name"] as? [String : AnyObject]{
                                        //First name
                                        if let firstName = fullName["first"] as? String{
                                            person.firstName = firstName;
                                        }
                                        //Last name
                                        if let lastName = fullName["last"] as? String{
                                            person.lastName = lastName;
                                            
                                        }
                                    }
                                    //Location
                                    if let location = field["location"] as? [String : AnyObject]{
                                        //street
                                        if let street = location["street"] as? String{
                                            person.street = street;
                                        }
                                        if let city = location["city"] as? String{
                                            person.city = city;
                                        }
                                        if let state = location["state"] as? String{
                                            person.state = state;
                                        }
                                    }
                                    //Email
                                    if let email = field["email"] as? String{
                                        print(email);
                                        person.email = email;
                                    }
                                    //Phone
                                    if let phone = field["phone"] as? String{
                                        person.phone = phone;
                                    }
                                    //Cell
                                    if let cell = field["cell"] as? String{
                                        person.cell = cell;
                                    }
                                    //Image
                                    if let picture = field["picture"] as? [String : AnyObject]{
                                        if let large = picture["large"] as? String{
                                            person.largeImg = large;
                                        }
                                        if let medium = picture["medium"] as? String{
                                            person.mediumImg = medium;
                                        }
                                        if let thumbnail = picture["thumbnail"] as? String{
                                            person.thumbnailImg = thumbnail;
                                        }
                                    }
                                    
                                }
                                
                                onCompletion(person)
                                
                                
                            }
    
        
        }
    }
}

