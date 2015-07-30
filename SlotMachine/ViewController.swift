//
//  ViewController.swift
//  SlotMachine
//
//  Created by lapacino on 7/29/15.
//  Copyright (c) 2015 lapacino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var slots:[[Slot]] = []
    
    // container
    
    var firstContainer:UIView!
    var secondContainer:UIView!
    var thirdContainer:UIView!
    var fourthContainer:UIView!
    
    // label
    
    var titleLabel:UILabel!
    var creditTitleLabel:UILabel!
    var betTitleLabel:UILabel!
    var winningsTiltlLabel:UILabel!
    var creditLabel:UILabel!
    var betLabel:UILabel!
    var winningLabel:UILabel!
    
    // button
    
    var resetButton:UIButton!
    var betButton:UIButton!
    var betMaxButton:UIButton!
    var spinButton:UIButton!



    let KContainerNumber = 3
    let kSlotNumber = 3
    
    let SlotMargin:CGFloat = 3.0
    let kMargin:CGFloat = 5.0
    let kTenth:CGFloat = 1/10.0
    let kThird:CGFloat = 1.0/3.0
    
    var creditsCount = 0
    var betCount = 0
    var winCount = 0
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.greenColor()
        setUpContainer()
        setUpFirstContainer(firstContainer)
        setUpThirdContainer(thirdContainer)
        hardReset()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func resetButton (sender:UIButton) {
        hardReset()
    }
    
    func betButton (sender:UIButton) {
        
        
        if creditsCount > 0 && betCount < 5 {
            creditsCount -= 1
            betCount += 1
            updateMainView()
            
        } else if betCount == 5 {
            showAlertWithText( message: "you can bet five credit at a time")
        }
        else{
            showAlertWithText(message: "You have no more money")
        }
    }
    func betMaxButton (sender:UIButton) {
        
        if creditsCount > 0 && betCount < 5 {
            creditsCount -= 5 - betCount
            betCount = 5
            updateMainView()
            
        } else if betCount == 5 {
            showAlertWithText( message: "you can bet five credit at a time")
        }
        else{
            showAlertWithText(message: "You have no more money")
        }
    }
    
    
    
    func spinButton (sender:UIButton) {
        removeSlotImage()
        slots = Factory.slotMachine()
        setUpSecondContainer(secondContainer)
        var winnings = SlotBrain.computeWinnings(slots)
        winCount = winnings * betCount
        creditsCount += winCount
        betCount = 0
        updateMainView()
    }
    
    func setUpContainer() {
        
        firstContainer = UIView(frame:CGRectMake(view.bounds.origin.x + kMargin, view.bounds.origin.y, view.bounds.width - kMargin * 2 , view.bounds.height * kTenth))
        firstContainer.backgroundColor = UIColor.greenColor()
        view.addSubview(firstContainer)
        
        secondContainer = UIView(frame: CGRectMake(view.bounds.origin.x + kMargin, view.bounds.origin.y + firstContainer.frame.height + kMargin  , view.bounds.width - kMargin * 2, view.bounds.height * 7 * kTenth))
        secondContainer.backgroundColor = UIColor.greenColor()
        view.addSubview(secondContainer)
        
        thirdContainer = UIView(frame:CGRectMake(view.bounds.origin.x + kMargin  , view.bounds.origin.y + firstContainer.frame.height + secondContainer.frame.height + 2 * kMargin , view.bounds.width - kMargin * 2 , view.bounds.height * kTenth * 2))
        thirdContainer.backgroundColor = UIColor.greenColor()
        view.addSubview(thirdContainer)
    }
    
    func setUpFirstContainer(containerView:UIView!) {
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slot"
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.font = UIFont(name: "Chalkduster", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView!.addSubview(titleLabel)
        
    }
    
    func setUpSecondContainer(containerView:UIView) {
      
        for var containerNumber = 0; containerNumber < KContainerNumber; containerNumber++ {
            for var slotNumber = 0; slotNumber < kSlotNumber; slotNumber++ {
                var slotImageView = UIImageView()
                var slot:Slot
                
                if slots.count != 0 {
                    
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }
                else{
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.frame.size.width * kThird * CGFloat(slotNumber) + SlotMargin), y: containerView.bounds.origin.y + (containerView.frame.size.height * kThird * CGFloat(containerNumber) + SlotMargin), width: containerView.bounds.width * kThird - kMargin, height: containerView.bounds.height * kThird - kMargin)
                containerView.addSubview(slotImageView)

            }
        }
        
    }
    
    func setUpThirdContainer(containerView:UIView) {
        
        self.creditTitleLabel = UILabel()
        self.creditTitleLabel.text = "Credits"
        self.creditTitleLabel.textColor = UIColor.whiteColor()
        self.creditTitleLabel.font = UIFont(name: "Georgia-Bold", size: 17)
        self.creditTitleLabel.sizeToFit()
        self.creditTitleLabel.center = CGPoint(x:containerView.bounds.size.width * kTenth * 2 , y: containerView.bounds.size.height * kTenth )
        containerView.addSubview(creditTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.whiteColor()
        self.betTitleLabel.font = UIFont(name: "Georgia-Bold", size: 17)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x:containerView.bounds.size.width * kTenth * 5 , y: containerView.bounds.size.height * kTenth )
        containerView.addSubview(betTitleLabel)
        
        self.winningsTiltlLabel = UILabel()
        self.winningsTiltlLabel.text = "Winnings"
        self.winningsTiltlLabel.textColor = UIColor.whiteColor()
        self.winningsTiltlLabel.font = UIFont(name: "Georgia-Bold", size: 17)
        self.winningsTiltlLabel.sizeToFit()
        self.winningsTiltlLabel.center = CGPoint(x:containerView.bounds.size.width * kTenth * 8, y: containerView.bounds.size.height * kTenth )
        containerView.addSubview(winningsTiltlLabel)
        
        self.creditLabel = UILabel()
        self.creditLabel.text = "0000"
        self.creditLabel.textColor = UIColor.redColor()
        self.creditLabel.font = UIFont(name: "Georgia-Bold", size: 17)
        self.creditLabel.sizeToFit()
        self.creditLabel.center = CGPoint(x:containerView.bounds.size.width * kTenth * 2 , y: containerView.bounds.size.height * kTenth  * 4)
        self.creditLabel.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(creditLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Georgia-Bold", size: 17)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x:containerView.bounds.size.width * kTenth * 5 , y: containerView.bounds.size.height * kTenth * 4)
        self.betLabel.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(betLabel)
        
        self.winningLabel = UILabel()
        self.winningLabel.text = "0000"
        self.winningLabel.textColor = UIColor.redColor()
        self.winningLabel.font = UIFont(name: "Georgia-Bold", size: 17)
        self.winningLabel.sizeToFit()
        self.winningLabel.center = CGPoint(x:containerView.bounds.size.width * kTenth * 8, y: containerView.bounds.size.height * kTenth * 4)
        self.winningLabel.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(winningLabel)
        
        self.resetButton = UIButton()
        self.resetButton.setTitle("reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 17)
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x:containerView.bounds.size.width * kTenth , y: containerView.bounds.size.height * kTenth * 7)
        self.resetButton.addTarget(self, action: "resetButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.resetButton.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(resetButton)
        
        self.betButton = UIButton()
        self.betButton.setTitle("bet", forState: UIControlState.Normal)
        self.betButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 17)
        self.betButton.sizeToFit()
        self.betButton.center = CGPoint(x:containerView.bounds.size.width * kTenth * 3.5, y: containerView.bounds.size.height * kTenth * 7)
        self.betButton.addTarget(self, action: "betButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.betButton.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(betButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("betmax", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 17)
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x:containerView.bounds.size.width * kTenth * 6.5, y: containerView.bounds.size.height * kTenth * 7)
        self.betMaxButton.addTarget(self, action: "betMaxButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.betMaxButton.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 17)
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x:containerView.bounds.size.width * kTenth * 9, y: containerView.bounds.size.height * kTenth * 7)
        self.spinButton.addTarget(self, action: "spinButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.spinButton.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(spinButton)
    }
    
    
    
    func hardReset() {
        removeSlotImage()
        slots.removeAll(keepCapacity: true)
        self.setUpSecondContainer(self.secondContainer)
        creditsCount = 50
        betCount = 0
        winCount = 0
        updateMainView()
        
    }
    
    func removeSlotImage() {
        
        if self.secondContainer != nil {
            
            let container:UIView = self.secondContainer!
            let subViews:Array? = container.subviews
            
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
        
    }
    
    func updateMainView() {
        
        self.creditLabel.text = String(creditsCount)
        self.betLabel.text = String(betCount)
        self.winningLabel.text = String(winCount)
    }
    
    func showAlertWithText(header:String = "Warning", message:String) {
        
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    


}

