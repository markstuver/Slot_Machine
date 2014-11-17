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
    
// ARRAY OF ARRAY OF SLOT INSTANCES
    var slots:[[Slot]] = []
    
// STATS
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    
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
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        
        // Reset All and load secondContainer
        hardReset()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
// IBAction Functions
    
   /// REST BUTTON ACTION
    func restButtonPressed (button:UIButton) {

        hardReset()
    }
    
  /// BET ONE BUTTON ACTION
    func betOneButtonPressed (button:UIButton) {
        
        // If user does not have enough credits
        if credits <= 0 {
            
            // Show this alert
            showAlertWithText(header: "No More Credits", message: "Reset Game")
            
        }
        else {
            // else... if currentBet is less then 5
            if currentBet < 5 {
                
                // add credit to bet as user press button
                currentBet += 1
                
                // subtract credit due to bet
                credits -= 1
                
                // update view
                updateMainView()
            }
            else {
                // else user has 5 and trying to go higher and they cant so show allert
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
    }
    
  /// BET MAX BUTTON ACTION
    func betMaxButtonPressed (button:UIButton) {
        
        // if the user does not have enough credits
        if credits < 5 {
            
            // show alert
            showAlertWithText(header: "Not Enough Credits", message: "Bet Less")
        }
        else {
        
            // else.. if current bet is less than 5
            if currentBet < 5 {
                
                // create instance equal to the max bet (5) minus the currentBet amount
                var creditsToBetMax = 5 - currentBet
                
                // subtract the amount that will be added to the current bet inorder to make it max
                credits -= creditsToBetMax
                
                // add the amount needed to make currentBet at its max (5)
                currentBet += creditsToBetMax
                
                // Update View
                updateMainView()
            }
            else {
                
                showAlertWithText(message: "You can only bet 5 credits at a time!") 
            }
        }
        
//        // Set current bet to the max (5)
//        currentBet = 5
//        //
//        credits -= 5
//        updateMainView()
    }
    
  /// SPIN BUTTON ACTION
    func spinButtonPressed (button:UIButton) {
        
        // Remove any old imageViews
        self.removeSlotImageViews()
        
        // Create a new set of slots when spin button is pressed
        slots = Factory.createSlots()
        
        // Update secondContainer with new set of slots
        setupSecondContainer(self.secondContainer)
        
        // Create a variable and set to the return of calling the computerWinnings class method
        var winningsMultiplier = SlotBrain.computeWinnings(slots)
        
        // Set winnings equal to the returned winningsMultiplier times the currentBet (The more credits bet the higher the winnings
        winnings = winningsMultiplier * currentBet
        
        // Add winnings to user's credits
        credits += winnings
        
        // Reset current Bet to 0
        currentBet = 0
        
        // Update view
        updateMainView()
        
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
    
    
//MARK: - CONTAINER SETUPS
    
// FIRST CONTAINER
    func setupFirstContainer(containerView:UIView) {
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
    }
    
// SECOND CONTAINER
    func setupSecondContainer(containerView:UIView) {
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                // Create instance of Slot
                var slot:Slot
                
                var slotImageView = UIImageView()
                
                // Check if a slot has been created (Spin button pressed)
                if slots.count != 0 {
                    
                    /// Create slotContainer instance and set using the slots Array and using the current containerNumber for the index#
                    let slotContainer = slots[containerNumber]
                    
                    /// set the slot from the current slotArray/Container using the current slotNumber for the index #
                    slot = slotContainer[slotNumber]
                    
                    /// set the slot image using the image property of the current slot
                    slotImageView.image = slot.image
                }
                else {
                    // else: just display a bunch of aces
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                
                containerView.addSubview(slotImageView)
            }
        }
    }
    
// THIRD CONTAINER
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


// FOURTH CONTAINER

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
    
// REMOVE SLOT IMAGEVIEWS: Removes the current set of slot images before the next set of slots are loaded. This helps clear memory usage.
    func removeSlotImageViews() {
        
        // does the secondContainer exsist? (this is not a necessary check because of the Optionals used before.
        if self.secondContainer != nil {
            
            // Using an optional because if instance does not have a value, we want it to pass nil not crash the program
            // Create optional instance of UIView set equal to the secondContainer
            let container: UIView? = self.secondContainer
            
            // Create optional Array and set it to the secondContainer's subviews (slot images)
            let subViews: Array? = container!.subviews
            
            // for every view in the subViews array...
            for view in subViews! {
                
                // ...remove the view from its superview
                view.removeFromSuperview()
            }
        }
    }
   
// HARD RESET FUNCTION
    func hardReset() {
        
        // call helper function to remove the current slot imageViews
        removeSlotImageViews()
        
        // Call the removeAll array method on the slots array. Keep capacity since we know that the next time the game is played it will need the same amount of slots loaded.
        slots.removeAll(keepCapacity: true)
        
        // Call to refresh the Second Container
        self.setupSecondContainer(self.secondContainer)
        
        // Reset all stats
        credits = 50
        winnings = 0
        currentBet = 0
        
        // Call function to update STATS Labels
        

        updateMainView()
    }
    
// UPDATE STATS LABELS
    func updateMainView() {
        
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
// ALERTS
    
    func showAlertWithText (header : String = "Warning", message : String) {
        
        
    var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    
    
    

}

