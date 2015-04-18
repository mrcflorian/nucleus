//
//  NLFYoutubePlayerView.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 4/18/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

public class NLFYoutubePlayerView: UIWebView
{
    public func playVideo(videoURL: String) {
        let htmlString = self.htmlCode(videoURL)
        self.loadHTMLString(htmlString, baseURL: nil)
    }
    
    func htmlCode(videoURL: String) -> String
    {
        return "<html><body><iframe src=\"" + videoURL + "\" width=\"300\" height=\"150\" frameborder=\"0\" allowfullscreen></iframe></body></html>"
    }
}
