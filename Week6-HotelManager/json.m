//
//  json.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/8/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

//class func userInfoFromJSONData(jsonData : NSData) -> [User]? {
//  
//  var error: NSError?
//  var users = [User]()
//  
//  if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject] {
//    
//    if let items = rootObject["items"] as? [[String: AnyObject]] {
//      for userRecord in items {
//        
//        if let login = userRecord["login"] as? String,
//          avatar_url = userRecord["avatar_url"] as? String,
//          id = userRecord["id"] as? Int
//          
//        {
//          let user = User(login: login, avatar_url: avatar_url, avatar_image: nil, id: id)
//          users.append(user)
//        } else {
//          println("There is a problem with your data")
//        }
//      }
//    }
//    
//  }
//  
//  if let error = error {
//    println(error.description)
//    return nil
//  } else {
//    return users
//  }
//  
//  }
//