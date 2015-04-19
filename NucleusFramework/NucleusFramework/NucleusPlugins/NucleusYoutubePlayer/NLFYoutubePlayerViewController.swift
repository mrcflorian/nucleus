//
//  NLFYoutubePlayerViewController.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 4/18/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

public let kYoutubePlayerViewDidAppear = "kYoutubePlayerViewDidAppear"

public class NLFYoutubePlayerViewController: NLFNucleusViewController, YTPlayerViewDelegate
{
    let playerVars = ["playsinline" : true]

    public var youtubePlayerView = YTPlayerView()
    public var playerIsReady = false
    
    override public func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        self.youtubePlayerView.delegate = self;
        self.youtubePlayerView.frame = self.view.bounds
        view.addSubview(self.youtubePlayerView)
        NSNotificationCenter.defaultCenter().postNotificationName(kYoutubePlayerViewDidAppear, object: self.youtubePlayerView)
    }
    
    public func playYoutubeVideo(videoID: String)
    {
        self.youtubePlayerView.loadWithVideoId(videoID, playerVars: playerVars)
    }

    public func playerViewDidBecomeReady(playerView: YTPlayerView!) {
        playerIsReady = true
    }
}
