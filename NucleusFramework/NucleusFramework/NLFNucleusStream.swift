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
    var isLoadingTop = false

    public init(apiRequest: NLFNucleusAPIRequest, jsonDecoder: NLFNucleusJSONDecoder)
    {
        self.apiRequest = apiRequest
        self.jsonDecoder = jsonDecoder
        super.init()
    }

    public func loadTop(batchSize: Int = kDefaultBatchSize)
    {
        if (self.isLoadingTop) {
            return
        }

        if (apiRequest.params == nil) {
            apiRequest.params = ["top_id":self.firstId()]
        } else {
            apiRequest.params!["top_id"] = String(self.firstId())
        }

        self.isLoading = true
        NLFNucleusAPI.request(apiRequest) {(data, response, error) in
            var resultArray = Array<AnyObject>()
            let dictJSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            if let dictArray = dictJSON as? Array<NSDictionary> {
                for jsonDictionary in dictArray {
                    resultArray.append(self.jsonDecoder.decodeFromJSONDictionary(jsonDictionary))
                }
            }
            self.objects = (resultArray + self.objects)
            NSNotificationCenter.defaultCenter().postNotificationName(kNLFNucleusStreamDidUpdate, object:self)
            self.isLoadingTop = false
        }
    }


    public func loadMore(batchSize: Int = kDefaultBatchSize, forced: Bool = false)
    {
        if ((self.isFinished && !forced) || self.isLoading) {
            return
        }

        if (self.isFinished && forced) {
            self.isFinished = false
        }

        if (apiRequest.params == nil) {
            apiRequest.params = ["skip":String(objects.count)]
        } else {
            apiRequest.params!["skip"] = String(objects.count)
        }

        self.isLoading = true
        NLFNucleusAPI.request(apiRequest) {(data, response, error) in
            var resultArray = Array<AnyObject>()
            let dictJSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            if let dictArray = dictJSON as? Array<NSDictionary> {
                for jsonDictionary in dictArray {
                    resultArray.append(self.jsonDecoder.decodeFromJSONDictionary(jsonDictionary))
                }
            }
            NSLog("%d", resultArray.count)
            if (resultArray.count == 0) {
                self.isFinished = true
            } else {
                self.objects += resultArray
                NSNotificationCenter.defaultCenter().postNotificationName(kNLFNucleusStreamDidUpdate, object:self)
            }
            self.isLoading = false
        }
    }

    func firstId() -> String
    {
        if (count(self.objects) > 0) {
            return (self.objects.first! as! NLFNucleusStreamableOject).getId()
        }
        return ""
    }
}

public protocol NLFNucleusJSONDecoder
{
    func decodeFromJSONDictionary(jsonDictionary: NSDictionary) -> NLFNucleusStreamableOject
}

public protocol NLFNucleusStreamableOject : AnyObject
{
    func getId() -> String
}
