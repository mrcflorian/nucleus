//
//  NLFNucleusAPI.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 4/8/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

public class NLFNucleusAPI: NSObject {
    public class func request(request: NLFNucleusAPIRequest, completion: ((NSData!, NSURLResponse!, NSError!) -> Void)?)
    {
        let url = NSURL(string: NLFNucleusAPI.urlString(request))
        if (url != nil) {
            let task = NLFURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                if completion != nil {
                    completion! (data, response, error)
                }
            }
            task.resume()
        }
    }
    
    class func urlString(request: NLFNucleusAPIRequest) -> String
    {
        var path = kNucleusDefaultEndpointBaseURL + request.path + "?"
        if request.params != nil {
            for (field, value) in request.params!
            {
                path += field + "=" + value + "&"
            }
        }
        return path
    }
}
