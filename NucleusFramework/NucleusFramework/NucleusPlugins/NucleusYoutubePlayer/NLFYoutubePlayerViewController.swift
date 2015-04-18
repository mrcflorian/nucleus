//
//  NLFYoutubePlayerViewController.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 4/18/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

public class NLFYoutubePlayerViewController: NLFNucleusViewController, YTPlayerViewDelegate
{
    var youtubePlayerView = YTPlayerView()
    
    override public func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        self.youtubePlayerView.delegate = self;
        self.youtubePlayerView.frame = self.view.bounds
        view.addSubview(self.youtubePlayerView)
        let playerVars = ["playsinline" : true]
        self.youtubePlayerView.loadWithVideoId("b_QI94xu36s", playerVars: playerVars)
    }
    
    public func playYoutubeVideo(videoID: String)
    {
        //self.youtubePlayerView.loadWithVideoId(videoID)
    }
}
