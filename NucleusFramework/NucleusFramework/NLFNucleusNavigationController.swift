//
//  NLFNucleusNavigationController.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/19/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

public class NLFNucleusNavigationController: UINavigationController
{
    public func didTapCancelButton(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
