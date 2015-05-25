//
//  NLFNucleusStreamifiedTableViewController.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/21/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

let kReachedBottomOffset: CGFloat = 0.0

public class NLFNucleusStreamifiedTableViewController: NLFNucleusTableViewController {
    public var stream: NLFNucleusStream? {
        didSet {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "streamDidUpdate:", name: kNLFNucleusStreamDidUpdate, object: stream)
            stream!.loadMore()
        }
    }

    public init (apiRequest: NLFNucleusAPIRequest, jsonDecoder: NLFNucleusJSONDecoder) {
        stream = NLFNucleusStream(apiRequest: apiRequest, jsonDecoder: jsonDecoder)
        super.init(nibName: nil, bundle: nil)
    }

    required public init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override public func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + kReachedBottomOffset >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            stream?.loadMore()
        }
    }

    func streamDidUpdate(notification: NSNotification) {
        if (self.stream != nil && notification.object != nil && notification.object!.isEqual(self.stream!)) {
            self.tableView.reloadData()
        }
    }

    override public func objects() -> [AnyObject] {
        return self.stream!.objects
    }

    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (nil != self.stream) {
            return self.stream!.objects.count
        }
        return 0
    }
}
