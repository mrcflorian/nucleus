//
//  NLFNucleusTextView.swift
//  NucleusFramework
//
//  Created by Florian Marcu on 5/23/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

public class NLFNucleusTextView: UITextView, UITextViewDelegate
{
    let placeHolderLabel = UILabel()
    public init(placeHolderString: String?) {
        self.placeHolderLabel.text = placeHolderString
        self.placeHolderLabel.textColor = UIColor.grayColor()

        super.init(frame: CGRectZero, textContainer: nil)

        self.delegate = self
        self.addSubview(placeHolderLabel)
    }

    public override func layoutSubviews() {
        let labelSize = placeHolderLabel.sizeThatFits(self.bounds.size)
        placeHolderLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, labelSize.width, labelSize.height)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func textViewDidChange(textView: UITextView) {
        self.placeHolderLabel.hidden = (count(self.text) > 0)
    }

    public func textViewDidEndEditing(textView: UITextView) {
        self.placeHolderLabel.hidden = (count(self.text) > 0)
    }
}
