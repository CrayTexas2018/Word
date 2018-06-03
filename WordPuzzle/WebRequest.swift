//
//  WebRequest.swift
//  WordPuzzle
//
//  Created by Cray Jaeger on 6/3/18.
//  Copyright © 2018 Cray Jaeger. All rights reserved.
//

import Foundation
import Alamofire


public class WebRequest
{
    var url: String
    
    init(url: String)
    {
        self.url = url
    }
    
    public func JsonGETRequest() -> String
    {
        url = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(self.url)
            .responseJSON { response in
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                // get and print the title
                guard let todoTitle = json["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
        }
        return ""
    }
}



