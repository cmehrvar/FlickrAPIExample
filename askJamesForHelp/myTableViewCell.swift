//
//  myTableViewCell.swift
//  askJamesForHelp
//
//  Created by Cina Mehrvar on 2015-11-04.
//  Copyright © 2015 Cina Mehrvar. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    var isExpanded = false
    
    @IBOutlet weak var myCellImage: UIImageView!
    
    @IBOutlet weak var cellCentringConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        andGestures()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func andGestures() {
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        longPressRecogniser.delegate = self
        self.addGestureRecognizer(longPressRecogniser)
        let panRecogniser = UIPanGestureRecognizer(target: self, action: "panOnCell:")
        panRecogniser.delegate = self
        self.addGestureRecognizer(panRecogniser)
    }
    
    func toggleCellImage() {
        UIView.animateWithDuration(0.3) {
            () -> Void in
            if !self.isExpanded {
                self.myCellImage?.transform =  CGAffineTransformMakeScale(1.1, 1.1)
            } else {
                self.myCellImage?.transform =  CGAffineTransformIdentity
            }
        }
        isExpanded = !isExpanded
    }
    
    func expandImage() {
        UIView.animateWithDuration(0.3) {
            () -> Void in
            self.myCellImage?.transform =  CGAffineTransformMakeScale(1.1, 1.1)
        }
        isExpanded = true
    }
    func contractImage() {
        UIView.animateWithDuration(0.3) {
            () -> Void in
            self.myCellImage?.transform = CGAffineTransformIdentity
        }
        isExpanded = false
    }
    
    
    
    func longPressed(sender: UILongPressGestureRecognizer) {
        print("Long Pressed")
        switch sender.state {
        case .Began:
            expandImage()
        case .Ended:
            contractImage()
        default:
            print("default state")
        }
    }
    
    func panOnCell(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self)
        switch sender.state {
        case .Changed:
            if isExpanded {
                cellCentringConstraint.constant = translation.x
            }
        case .Ended:
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.cellCentringConstraint.constant = 0
            })
        default:
            print("default state")
        }
    }
    
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    
    
}
