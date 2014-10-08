//
//  ViewController.swift
//  SlotMachine
//
//  Created by Mark Stuver on 10/7/14.
//  Copyright (c) 2014 Mark Stuver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
// CONTAINERS
    
    // an implicate unwrapped optional... ? is used if an instance could be nil. If you know that you will always have a specific object, use a !
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
// CONSTANTS

    
    let kMarginForView:CGFloat = 10.0
    let kSixth:CGFloat = 1.0/6.0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainerViews()
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
// HELPER FUNCTION

    // function is called to setup the view containers inside the view
    func setupContainerViews() {
        
    /* First Container... it is a view container that is a subview of the main View.
    ***FOR BREAKDOWN OF THE SETTING UP THE FIRST CONTAINER's VIEW - SEE UIVIEW PLAYGROUND***
        Setup the firstContainer's view frame inside the main View using a CGRect */
        self.firstContainer = UIView(frame:
            // to create a CGRect... use the CGRectMake function
            CGRectMake(
                self.view.bounds.origin.x + kMarginForView,
                self.view.bounds.origin.y,
                self.view.bounds.width - (kMarginForView * 2),
                self.view.bounds.height * kSixth))
        
        self.firstContainer.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(self.firstContainer)
        
        
    }

}

