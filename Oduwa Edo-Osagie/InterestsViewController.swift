//
//  interestsViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 22/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIDynamicAnimatorDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellHeight : CGFloat = 250;
    var images = ["clipperboard", "laptop", "literature", "code", "guitar", "unisef", "basketball"];
    var allowUserToLeave : Bool = true;
    
    var clipperBoardText = "I am a bit of a cinephile! Watching movies and TV shows is one of my favourite things to do. Some of my favourite films are \"Pulp Fiction\" and the \"The Grand Budapest Hotel\". I also like anime. (This is what inspired my first app - AnimeHub).";
    
    var laptopText = "I like new technology and gadgets. I am subscribed to a number of online tech magazines. I find it interesting to read about and compare different devices and their capabilities.";
    
    var literatureText = "I also read in my spare time. For school, I read academic journals so that I can see how what I am learning is applied in the real world today. My favourite pieces of literature however, are \"The Catcher In The Rye\" and the Harry Potter series."
    
    var codeText = "I like to build things with code! One thing to excite me recently is NSLinguisticTagger. I just discovered it and I think it has the potential to re-imagine (or at least augment) the ways we interact with our devices."
    
    var guitarText = "I love music. I learned to play the piano in secondary school and started teaching myself to play the guitar in January this year";
    
    var unisefText = "I have done some volunteer work with Isabel Hospice and Save The Children. I would like to see developing countries benefit more from technology.";
    
    var sportsText = "I occassionally play football, basketball and tennis. I don't enjoy watching them though (Why watch it when you can just do it!)";
    
    var descriptionText = ["", "", "", "", "", "", "", ""];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Nav Bar */
        self.navigationController?.navigationBarHidden = true;
        
        /* Back Button */
        var closeButton : UIButton = UIButton(frame: CGRectMake(0, 0, 50, 50));
        closeButton.setImage(UIImage(named: "close"), forState: UIControlState.Normal);
        closeButton.addTarget(self, action: Selector("backButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside);
        self.collectionView.addSubview(closeButton);
        
        /* Collection View Setup */
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        var rubberLayout = self.collectionView.collectionViewLayout as! VPRubberLayout;
        rubberLayout.dynamicAnimator.delegate = self;
        
        /* Description text setup */
        descriptionText[0] = clipperBoardText;
        descriptionText[1] = laptopText;
        descriptionText[2] = literatureText;
        descriptionText[3] = codeText;
        descriptionText[4] = guitarText;
        descriptionText[5] = unisefText;
        descriptionText[6] = sportsText;
    }
    
    override func viewWillAppear(animated: Bool) {
        self.layoutProperly();
        super.viewWillAppear(animated);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Collection View DataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : VPRubberCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! VPRubberCell;
        cellHeight = cell.frame.height;
        cell.backgroundColor = self.colourForIndexPath(indexPath);
        cell.iconView2.image = UIImage(named: images[indexPath.row]);
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let requiredWidth = collectionView.bounds.size.width
        let targetSize = CGSize(width: requiredWidth, height: cellHeight)
        return targetSize
    }
    
    
    // MARK: Collection View Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        SwiftAppUtils.sharedInstance.currentInterestText = descriptionText[indexPath.row];
        SwiftAppUtils.sharedInstance.currentInterestColour = self.colourForIndexPath(indexPath);
        self.performSegueWithIdentifier("showText", sender: self);
    }
    
    
    // MARK : VPRubberMenu
    
    func layoutProperly(){
        // Fixing visual glitch with bouncing of UICollectionView
        
        var newView : UIView = UIView(frame: self.view.bounds);
        var top : UIView = UIView(frame: CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height/2));
        var bot : UIView = UIView(frame: CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, newView.bounds.size.height/2));
        
        top.backgroundColor = self.colourForIndexPath(NSIndexPath(forRow: 0, inSection: 0));
        bot.backgroundColor = self.colourForIndexPath(NSIndexPath(forRow: images.count-1, inSection: 0));
        
        newView.addSubview(top);
        newView.addSubview(bot);
        
        
        self.view.addSubview(newView);
        self.view.bringSubviewToFront(self.collectionView);
        self.collectionView.backgroundColor = UIColor.clearColor();
        
        var cf : CGRect = self.collectionView.frame;
        cf.origin.y -= CGFloat(CELLS_ALLIGN);
        cf.size.height += CGFloat(CELLS_ALLIGN);
        self.collectionView.frame = cf;
    }
    
    func colourForIndexPath(indexPath : NSIndexPath) -> UIColor {
        switch(indexPath.row){
        case 0:
            return UIColor(red: 246/255, green: 255/255, blue: 128/255, alpha: 1.0);
        case 1:
            return UIColor(red: 87/255, green: 220/255, blue: 255/255, alpha: 1.0);
        case 2:
            return UIColor(red: 159/255, green: 108/255, blue: 143/255, alpha: 1.0);
        case 3:
            return UIColor(red: 241/255, green: 112/255, blue: 167/255, alpha: 1.0);
        case 4:
            return UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0);
        case 5:
            return UIColor(red: 87/255, green: 220/255, blue: 255/255, alpha: 1.0);
        case 6:
            return UIColor(red: 208/255, green: 199/255, blue: 237/255, alpha: 1.0);
        case 7:
            return UIColor(red: 159/255, green: 108/255, blue: 143/255, alpha: 1.0);
        case 8:
            return UIColor(red: 0/255, green: 106/255, blue: 109/255, alpha: 1.0);
        default:
            return UIColor(red: 0/255, green: 170/255, blue: 172/255, alpha: 1.0);
        }
    }
    
    
    // MARK: Animator Delegate
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        allowUserToLeave = true;
    }
    
    func dynamicAnimatorWillResume(animator: UIDynamicAnimator) {
        allowUserToLeave = false;
    }
    
    
    
    // MARK: Selectors
    
    func backButtonPressed(){
        if(allowUserToLeave){
            self.dismissViewControllerAnimated(true, completion: nil);
        }
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showText"){
            let t: TextPopupViewController = self.storyboard?.instantiateViewControllerWithIdentifier("textPopupViewController") as! TextPopupViewController;
            
            
            let formSheetSegue = segue as! MZFormSheetSegue;
            let formSheet = formSheetSegue.formSheetController;
            formSheet.cornerRadius = 4.0;
            var aspectRatio : CGFloat = 1.0
            let width = (SwiftAppUtils.getScreenResolutionSize().width*0.7)/UIScreen.mainScreen().scale;
            let height = SwiftAppUtils.calculateHeight(width, andAspectRatio: aspectRatio)
            formSheet.presentedFormSheetSize = CGSizeMake(width, height);
            
            formSheet.transitionStyle = MZFormSheetTransitionStyle.Bounce;
            formSheet.shouldDismissOnBackgroundViewTap = true;
            
            formSheet.shouldCenterVertically = true;
            
        }
    }
    
    
    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}

