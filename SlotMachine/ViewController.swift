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
    
// INFORMATION LABELS
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
// BUTTONS FOR FOURTH CONTAINER
    var restButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
// CONSTANTS

    var titleLabel: UILabel!
    
    let kMarginForView:CGFloat = 10.0
    let kMarginForSlot:CGFloat = 2.0
    
    let kSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0
    
    let kHalf:CGFloat = 1.0/2.0
    let kEight:CGFloat = 1.0/8.0
    
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainerViews()
        setupFirstContainer(self.firstContainer)
        setupSecondContainer(self.secondContainer)
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
// IBAction Functions
    
   /// REST BUTTON ACTION
    func restButtonPressed (button:UIButton) {
        println("reset button pressed")
    }
    
  /// BET ONE BUTTON ACTION
    func betOneButtonPressed (button:UIButton) {
        println("Bet One!")
    }
    
  /// BET ONE BUTTON ACTION
    func betMaxButtonPressed (button:UIButton) {
        println("Max Bet!")
    }
    
  /// SPIN BUTTON ACTION
    func spinButtonPressed (button:UIButton) {
        println("SPIN")
    }
    
// HELPER FUNCTION

    // function is called to setup the 1st view containers inside the view
    func setupContainerViews() {
    
    /* First Container... it is a view container that is a subview of the main View.
    ***FOR BREAKDOWN OF THE SETTING UP THE FIRST CONTAINER's VIEW - SEE UIVIEW PLAYGROUND***
        Setup the firstContainer's view frame inside the main View using a CGRect */
        self.firstContainer = UIView(frame:
            // to create a CGRect... use the CGRectMake function
            CGRectMake(self.view.bounds.origin.x + kMarginForView, self.view.bounds.origin.y, self.view.bounds.width - (kMarginForView * 2), self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
    }
    
    
    
    func setupFirstContainer(containerView:UIView) {
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
    }
    
    
    func setupSecondContainer(containerView:UIView) {
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slotImageView = UIImageView()
                slotImageView.backgroundColor = UIColor.yellowColor()
                
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    
    func setupThirdContainer(containerView: UIView) {
      
    /// CREDITS LABEL
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        
        // set the font and font size
        self.creditsLabel.font = UIFont(name: "Menlo-Bond", size: 16)
        
        // automatically creates a container that fits the text string's length
        self.creditsLabel.sizeToFit()
        
        // Put into the center of the container
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y:containerView.frame.height * kThird)
        
        // Align text to center
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        
        containerView.addSubview(self.creditsLabel)
        
    /// BET LABEL
        self.betLabel = UILabel()
        self.betLabel.text = "000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
    /// WINNER PAID LABEL
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
    /// CREDITS TITLE LABEL
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditsTitleLabel)
        
    /// BET TITLE LABEL
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLabel)

    ///  TITLE LABEL
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.winnerPaidTitleLabel)
    }

    
    func setupFourthContainer (containerView: UIView) {
        
        
    /// RESET BUTTON
        self.restButton = UIButton()
        // Set the title for the button's specific state
        self.restButton.setTitle("Reset", forState: UIControlState.Normal)
        self.restButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        // ? Makes titleLabel an optional just in case no value is available so it doesn't crash
        self.restButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.restButton.backgroundColor = UIColor.lightGrayColor()
        self.restButton.sizeToFit()
        self.restButton.center = CGPoint(x: containerView.frame.width * kEight, y: containerView.frame.height * kHalf)
        // Adding target as self (this view controller), action is a function that will be called, controlEvent is the event that will cause the button to activate.
        self.restButton.addTarget(self, action: "restButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.restButton)
    
    /// BET ONE BUTTON
        self.betOneButton = UIButton()
        // Set the title for the button's specific state
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        // ? Makes titleLabel an optional just in case no value is available so it doesn't crash
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEight, y: containerView.frame.height * kHalf)
        // Adding target as self (this view controller), action is a function that will be called, controlEvent is the event that will cause the button to activate.
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betOneButton)
        
        
    /// BET MAX BUTTON
        self.betMaxButton = UIButton()
        // Set the title for the button's specific state
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        // ? Makes titleLabel an optional just in case no value is available so it doesn't crash
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEight, y: containerView.frame.height * kHalf)
        // Adding target as self (this view controller), action is a function that will be called, controlEvent is the event that will cause the button to activate.
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        
    /// SPIN BUTTON
        self.spinButton = UIButton()
        // Set the title for the button's specific state
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        // ? Makes titleLabel an optional just in case no value is available so it doesn't crash
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEight, y: containerView.frame.height * kHalf)
        // Adding target as self (this view controller), action is a function that will be called, controlEvent is the event that will cause the button to activate.
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)

        

        
        
        
        
        
    }
    
    
    
    
    
    

}

