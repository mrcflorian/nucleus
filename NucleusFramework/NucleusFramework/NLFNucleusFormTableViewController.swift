//
//  NLFNucleusFormTableViewController.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/23/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

public class NLFNucleusFormTableViewController: UITableViewController
{
    let cellsArray: [NLFNucleusFormTableViewCell]?
    public init(formCells: [NLFNucleusFormTableViewCell]) {
        cellsArray = formCells
        super.init(nibName: nil, bundle: nil)
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.bounces = false
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("NLFNucleusFormTableViewController init not implemented")
    }

    public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row < cellsArray?.count) {
            return cellsArray![indexPath.row].height()
        }
        return kNLFNucleusTableViewCellDefaultHeight
    }

    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row < cellsArray?.count) {
            return cellsArray![indexPath.row]
        }
        return UITableViewCell()
    }

    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (cellsArray != nil) {
            return cellsArray!.count
        }
        return 0
    }
}