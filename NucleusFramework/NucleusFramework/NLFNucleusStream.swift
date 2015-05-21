//
//  NLFNucleusStream.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/21/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

public let kNLFNucleusStreamDidUpdate = "kNLFNucleusStreamDidUpdate"

let kDefaultBatchSize = 50

public class NLFNucleusStream: NSObject
{
    var objects = Array<AnyObject>()
    var isFinished = false
    let apiRequest: NLFNucleusAPIRequest
    let jsonDecoder: NLFNucleusJSONDecoder
    var isLoading = false

    public init(apiRequest: NLFNucleusAPIRequest, jsonDecoder: NLFNucleusJSONDecoder)
    {
        self.apiRequest = apiRequest
        self.jsonDecoder = jsonDecoder
        super.init()
    }

    public func loadMore(batchSize: Int = kDefaultBatchSize)
    {
        if (self.isFinished || self.isLoading) {
            return
        }

        if (apiRequest.params == nil) {
            apiRequest.params = ["skip":String(objects.count)]
        } else {
            apiRequest.params!["skip"] = String(objects.count)
        }

        self.isLoading = true
        NLFNucleusAPI.request(apiRequest) {(data, response, error) in
            var resultArray = Array<AnyObject>()
            var dictArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! Array<NSDictionary>
            for jsonDictionary in dictArray {
                resultArray.append(self.jsonDecoder.decodeFromJSONDictionary(jsonDictionary))
            }
            if (resultArray.count == 0) {
                self.isFinished = true
            } else {
                self.objects += resultArray
                NSNotificationCenter.defaultCenter().postNotificationName(kNLFNucleusStreamDidUpdate, object:self)
            }
            self.isLoading = false
        }
    }
}

public protocol NLFNucleusJSONDecoder
{
    func decodeFromJSONDictionary(jsonDictionary: NSDictionary) -> AnyObject
}
