//
//  ViewController.swift
//  FlickrAPIExample
//
//  Created by Cina Mehrvar on 2015-11-04.
//  Copyright © 2015 Cina Mehrvar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoTitle: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var myFlickerModel: Flick_Model!
    
    
    @IBAction func getImageFromFlickr(sender: AnyObject) {
        
        myFlickerModel.getImageFromFlickr()
        
    }
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFlickerModel = Flick_Model(photoView: photoImageView, myTitle: photoTitle)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

