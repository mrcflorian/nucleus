//
//  NLFNucleusTableViewController.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 4/11/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

let kNLFNucleusTableViewCellDefaultHeight: CGFloat = 30.0

public protocol NLFTableRowAdapterProtocol
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: AnyObject) -> UITableViewCell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath, object: AnyObject) -> CGFloat
}

public class NLFNucleusTableViewController: UITableViewController
{
    var adaptersArray: [(adapter: NLFTableRowAdapterProtocol, classRef: AnyClass)] = []
    
    public func use(adapter: NLFTableRowAdapterProtocol, classRef: AnyClass)
    {
        adaptersArray.append(adapter: adapter, classRef: classRef)
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let objects = self.objects()
        if (indexPath.row < objects.count) {
            var object: AnyObject = objects[indexPath.row]
            for (adapter,classRef) in adaptersArray {
                if (object.isKindOfClass(classRef)) {
                    return adapter.tableView(tableView, cellForRowAtIndexPath: indexPath, object: object)
                }
            }
        }
        return UITableViewCell()
    }

    public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let objects = self.objects()
        if (indexPath.row < objects.count) {
            var object: AnyObject = objects[indexPath.row]
            for (adapter,classRef) in adaptersArray {
                if (object.isKindOfClass(classRef)) {
                    return adapter.tableView(tableView, heightForRowAtIndexPath: indexPath, object: object)
                }
            }
        }
        return kNLFNucleusTableViewCellDefaultHeight
    }

    public func objects() -> [AnyObject] {
        assert(false)
    }
}
