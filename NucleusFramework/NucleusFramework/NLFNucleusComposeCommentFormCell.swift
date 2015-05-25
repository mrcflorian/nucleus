//
//  NLFNucleusComposeCommentFormCell.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/25/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

public class NLFNucleusComposeCommentFormCell: NLFNucleusTextFieldFormCell {

    var commentButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton

    public init(reuseIdentifier: String, placeHolderText: String?, buttonText: String?, height: CGFloat = kNLFNucleusTextFieldFormCellDefaultHeight) {
        super.init(reuseIdentifier: reuseIdentifier, placeHolderText: placeHolderText, height: height)
        self.commentButton.setTitle(buttonText, forState: UIControlState.Normal)
        self.commentButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.addSubview(self.commentButton)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        let buttonSize = self.commentButton.sizeThatFits(self.bounds.size)
        self.commentButton.frame = CGRectMake(self.bounds.origin.x + self.bounds.width - buttonSize.width, self.bounds.origin.y + (self.bounds.height - buttonSize.height) / 2, buttonSize.width, buttonSize.height)
        self.textView?.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.width - buttonSize.width, self.bounds.height)
    }

}
