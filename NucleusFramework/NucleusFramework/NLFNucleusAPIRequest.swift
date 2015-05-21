//
//  NLFNucleusAPIRequest.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 4/11/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

public class NLFNucleusAPIRequest: NSObject {
    let path: String
    var params: Dictionary <String, String>?
    public init(params: Dictionary <String, String>?, path: String)
    {
        self.params = params
        self.path = path
    }
}
