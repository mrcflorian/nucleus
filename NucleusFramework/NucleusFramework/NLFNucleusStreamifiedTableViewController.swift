//
//  NLFNucleusStreamifiedTableViewController.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/21/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

let kReachedBottomOffset: CGFloat = 0.0
let kReachedTopOffset: CGFloat = 200.0

public class NLFNucleusStreamifiedTableViewController: NLFNucleusTableViewController {
    public var hasPullToRefreshSupport = false

    public var stream: NLFNucleusStream? {
        didSet {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "streamDidUpdate:", name: kNLFNucleusStreamDidUpdate, object: stream)
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

    public override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (hasPullToRefreshSupport && scrollView.contentOffset.y <= -kReachedTopOffset) {
            stream?.loadTop()
        }
    }

    func streamDidUpdate(notification: NSNotification) {
        if (self.stream != nil && notification.object != nil && notification.object!.isEqual(self.stream!)) {
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }

    override public func objects() -> [AnyObject] {
        return self.stream!.objects as Array<AnyObject>
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
