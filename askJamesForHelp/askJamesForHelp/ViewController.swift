//
//  ViewController.swift
//  askJamesForHelp
//
//  Created by Cina Mehrvar on 2015-11-04.
//  Copyright © 2015 Cina Mehrvar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
   
    @IBOutlet var myTableView: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer) {
        print("Long Pressed")
        guard let cell = sender.view as? myTableViewCell else {return}
    
        switch sender.state {
            case .Began:
                cell.toggleCellImage()
                myTableView.userInteractionEnabled = false
            case .Ended:
                cell.toggleCellImage()
             myTableView.userInteractionEnabled = true
            
            default:
                print("default state")
        }
    }
    
    
    @IBAction func panOnCell(sender: UIPanGestureRecognizer) {
        guard let cell = sender.view as? myTableViewCell, image = cell.myCellImage else {return}
        let translation = sender.translationInView(view)
        
        switch sender.state {
        case .Changed:
            if cell.isExpanded {
                cell.cellCentringConstraint.constant = translation.x
            }
        case .Ended:
           // if cell.isExpanded {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    cell.cellCentringConstraint.constant = 0
                })
                
           // }
        default:
            print("default state")
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    
}

