//
//  NLFNucleusTextFieldFormCell.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/23/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

let kNLFNucleusTextFieldFormCellDefaultHeight: CGFloat = 100.0

public class NLFNucleusTextFieldFormCell: NLFNucleusFormTableViewCell {
    var textView: NLFNucleusTextView?

    public init(reuseIdentifier: String, placeHolderText: String?)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)

        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsetsMake(0, self.bounds.size.width, 0, 0)
        self.textView = NLFNucleusTextView(placeHolderString: placeHolderText)
        self.addSubview(self.textView!)
    }

    public required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    public override func layoutSubviews() {
        self.textView?.frame = self.bounds
    }

    public override func height() -> CGFloat {
        return kNLFNucleusTextFieldFormCellDefaultHeight
    }

    public override func becomeFirstResponder() -> Bool {
        return self.textView!.becomeFirstResponder()
    }
}
