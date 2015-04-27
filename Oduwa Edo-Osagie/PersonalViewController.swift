//
//  PersonalViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 19/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

let COLLAPSE_CONTENT_HEIGHT = UIScreen.mainScreen().bounds.height - 200;
//(UIScreen.mainScreen().bounds.height/3)*2;
//UIUIScreen.mainScreen().bounds.height*(2/3)


class PersonalViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerProfileImageView: UIImageView!
    @IBOutlet weak var headerNameLabel: UILabel!
    
    
    @IBOutlet weak var collapseButton1: UIButton!
    @IBOutlet weak var collapseButton2: UIButton!
    @IBOutlet weak var collapseButton3: UIButton!
    
    
    
    @IBOutlet weak var collapseSection1: UIView!
    @IBOutlet weak var collapseSection2: UIView!
    @IBOutlet weak var collapseSection3: UIView!
    
    
    @IBOutlet weak var section1BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var Section2_1TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var section2BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var section3BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var section3_2TopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    
    var collapseContent1 : CollapseView1!
    var collapseContent2 : CollapseView2!
    var collapseContent3 : CollapseView3!
    var topCollapseContraint : NSLayoutConstraint!
    var bottomCollapseContraint : NSLayoutConstraint!
    var leftCollapseContraint : NSLayoutConstraint!
    var rightCollapseContraint : NSLayoutConstraint!
    
    var currentlyShowing : Int = 0; // 0 means none showing, 1 means content 1 showing, and so on
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Nav Bar */
        self.navigationController?.navigationBarHidden = true;
        
        /* Back Button */
        self.backButton.addTarget(self, action: Selector("backButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside);
        
        /* Section Collapse Buttons */
        self.collapseButton1.addTarget(self, action: Selector("collapseButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside);
        self.collapseButton2.addTarget(self, action: Selector("collapseButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside);
        self.collapseButton3.addTarget(self, action: Selector("collapseButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside);
        
        /* Add Header */
        self.setupHeader();
        
        /* Prepare sections for programmatic autolayout modifications */
        self.collapseSection1.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.collapseSection2.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.collapseSection3.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.scrollView.setTranslatesAutoresizingMaskIntoConstraints(false);

        /* Add Content Views */
        self.setupContentViews();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Header Setup
    
    func setupHeader(){
        // Header
        self.headerView.backgroundColor = UIColor.whiteColor();
        self.headerView.alpha = 0.7;
        self.headerImageView.image = UIImage(named: "woods_blur.jpg");
        self.headerImageView.clipsToBounds = true;
        
        // Header profile
        roundImageView(self.headerProfileImageView);
        self.headerProfileImageView.image = UIImage(named: "woods.jpg");
        self.headerNameLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 22.0);
        self.headerNameLabel.sizeToFit();
    }
    
    // MARK: Content and Collapse Views Setup
    
    func setupContentViews(){
        collapseContent1 = CollapseView1.instanceFromNib() as! CollapseView1;
        collapseContent1.frame = CGRectMake(self.collapseSection1.frame.origin.x, self.collapseSection1.frame.origin.y+self.collapseSection1.frame.size.height, UIScreen.mainScreen().bounds.width, 1);
        collapseContent1.setTranslatesAutoresizingMaskIntoConstraints(false);
        collapseContent1.setup();

        
        collapseContent2 = CollapseView2.instanceFromNib() as! CollapseView2;
        collapseContent2.frame = CGRectMake(self.collapseSection2.frame.origin.x, self.collapseSection2.frame.origin.y+self.collapseSection2.frame.size.height, UIScreen.mainScreen().bounds.width, 1);
        collapseContent2.setTranslatesAutoresizingMaskIntoConstraints(false);
        collapseContent2.setup();

        
        collapseContent3 = CollapseView3.instanceFromNib() as! CollapseView3;
        collapseContent3.frame = CGRectMake(self.collapseContent3.frame.origin.x, self.collapseContent3.frame.origin.y+self.collapseSection3.frame.size.height, UIScreen.mainScreen().bounds.width, 1);
        collapseContent3.setTranslatesAutoresizingMaskIntoConstraints(false);
        collapseContent3.setup();
    }
    
    func roundImageView(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.bounds.height/2.0;
        imageView.layer.borderWidth = 3.0;
        imageView.layer.borderColor = UIColor.blackColor().CGColor;
        imageView.layer.masksToBounds = false;
        imageView.clipsToBounds = true;
    }
    
    func showCollapseView1(){

        self.scrollView.addSubview(collapseContent1);
        self.collapseContent1.alpha = 1;
        
        
        /* Top Contstraint */
        topCollapseContraint = NSLayoutConstraint(item: collapseContent1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection1, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0);
        self.scrollView.addConstraint(topCollapseContraint);
        
        /* Bottom Contstraint */
        bottomCollapseContraint = NSLayoutConstraint(item: collapseContent1, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection2, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: COLLAPSE_CONTENT_HEIGHT);
        self.scrollView.addConstraint(bottomCollapseContraint);
        
        /* Right Contstraint */
        rightCollapseContraint = NSLayoutConstraint(item: collapseContent1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection1, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        self.scrollView.addConstraint(rightCollapseContraint);
        
        
        /* Left Contstraint */
        leftCollapseContraint = NSLayoutConstraint(item: collapseContent1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection1, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0);
        self.scrollView.addConstraint(leftCollapseContraint);


        /* Animate to visible */
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded();
        }) { (success) -> Void in
            /* Update Scroll View content size to take collapsed view into account */
            self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height+COLLAPSE_CONTENT_HEIGHT/3);
        }
        
        
        
        currentlyShowing = 1;
    }
    
    func hideCollapseView1(){
        
        /* Remove bottom constraint to make content invisible */
        self.scrollView.removeConstraint(bottomCollapseContraint);

        /* Update Scroll View content size to take collapsed view into account */
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height-COLLAPSE_CONTENT_HEIGHT/3);
        
        /* Animate content away */
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded();
            }) { (success) -> Void in
                //self.collapseContent1.removeFromSuperview();
        }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.collapseContent1.alpha = 0;
        })
        
        currentlyShowing = 0;
    }
    
    func showCollapseView2(){

        self.scrollView.addSubview(collapseContent2);
        self.collapseContent2.alpha = 1;
        
        /* Top Contstraint */
        topCollapseContraint = NSLayoutConstraint(item: collapseContent2, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection2, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0);
        self.scrollView.addConstraint(topCollapseContraint);
        
        /* Bottom Contstraint */
        bottomCollapseContraint = NSLayoutConstraint(item: collapseContent2, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection3, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: COLLAPSE_CONTENT_HEIGHT*2/3);
        self.scrollView.addConstraint(bottomCollapseContraint);
        
        /* Right Contstraint */
        rightCollapseContraint = NSLayoutConstraint(item: collapseContent2, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection1, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        self.scrollView.addConstraint(rightCollapseContraint);
        
        
        /* Left Contstraint */
        leftCollapseContraint = NSLayoutConstraint(item: collapseContent2, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection1, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0);
        self.scrollView.addConstraint(leftCollapseContraint);

        
        /* Animate to visible */
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded();
            }) { (success) -> Void in
                // nothing
        }
        
        /* Update Scroll View content size to take collapsed view into account */
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height+(COLLAPSE_CONTENT_HEIGHT*1/3));
        
        /* frame selected section square within Scroll View */
        self.scrollView.scrollRectToVisible(CGRectMake(0, self.collapseSection1.frame.origin.y+self.collapseSection1.frame.size.height, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height), animated: true);
        
        
        currentlyShowing = 2;
        
    }
    
    func hideCollapseView2(){
        
        /* Remove bottom constraint to make content invisible */
        self.scrollView.removeConstraint(bottomCollapseContraint);
        
        /* Update Scroll View content size to take collapsed view into account */
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height-(COLLAPSE_CONTENT_HEIGHT*1/3));
        
        /* Animate content away */
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded();
            }) { (success) -> Void in
                self.view.layoutIfNeeded();
        }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.collapseContent2.alpha = 0;
        })
        
        currentlyShowing = 0;
    }
    
    func showCollapseView3(){

        self.scrollView.addSubview(collapseContent3);
        self.collapseContent3.alpha = 1;
        
        /* Top Contstraint */
        topCollapseContraint = NSLayoutConstraint(item: collapseContent3, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection3, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0);
        self.scrollView.addConstraint(topCollapseContraint);
        
        /* Bottom Contstraint */
        bottomCollapseContraint = NSLayoutConstraint(item: collapseContent3, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection3, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: COLLAPSE_CONTENT_HEIGHT*2/3);
        self.scrollView.addConstraint(bottomCollapseContraint);
        
        /* Right Contstraint */
        rightCollapseContraint = NSLayoutConstraint(item: collapseContent3, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection1, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        self.scrollView.addConstraint(rightCollapseContraint);
        
        /* Left Contstraint */
        leftCollapseContraint = NSLayoutConstraint(item: collapseContent3, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.collapseSection1, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0);
        self.scrollView.addConstraint(leftCollapseContraint);
        
        
        /* Animate to visible */
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded();
            }) { (success) -> Void in
                // nothing
        }
        
        /* Update Scroll View content size to take collapsed view into account */
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height+(COLLAPSE_CONTENT_HEIGHT*2/3));
        
        
        /* frame selected section square within Scroll View */
        self.scrollView.scrollRectToVisible(CGRectMake(0, self.collapseSection3.frame.origin.y+self.collapseSection3.frame.size.height, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height), animated: true);
        
        currentlyShowing = 3;
    }
    
    func hideCollapseView3(){
        
        /* Remove bottom constraint to make content invisible */
        self.scrollView.removeConstraint(bottomCollapseContraint);
        
        /* Update Scroll View content size to take collapsed view into account */
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height-(COLLAPSE_CONTENT_HEIGHT*2/3));
        
        /* Animate content away */
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded();
            }) { (success) -> Void in
                self.view.layoutIfNeeded();
        }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.collapseContent3.alpha = 0;
        })
        
        currentlyShowing = 0;
    }
    
    
    
    // MARK: Selectors
    
    func backButtonPressed(){
        NSNotificationCenter.defaultCenter().postNotificationName(kCenterOnPersonal, object: nil);
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func collapseButtonPressed(sender: UIButton){
        /* Hide any currently showing views */
        if(currentlyShowing > 0){
            var buttonToRotate = UIButton();
            
            if(currentlyShowing == 1){
                buttonToRotate = collapseButton1;
            }
            else if(currentlyShowing == 2){
                buttonToRotate = collapseButton2;
            }
            else if(currentlyShowing == 3){
                buttonToRotate = collapseButton3;
            }
            
            UIView.animateWithDuration(0.25,
                delay: 0.0,
                options: .CurveLinear,
                animations: {buttonToRotate.transform = CGAffineTransformRotate(buttonToRotate.transform, 3.1415926/2)},
                completion: nil)
            
            if(currentlyShowing == 1){
                self.hideCollapseView1();
            }
            else if(currentlyShowing == 2){
                self.hideCollapseView2();
            }
            else if(currentlyShowing == 3){
                self.hideCollapseView3();
            }
            
            currentlyShowing = 0;
        }
        else{
            UIView.animateWithDuration(0.25,
                delay: 0.0,
                options: .CurveLinear,
                animations: {sender.transform = CGAffineTransformRotate(sender.transform, -3.1415926/2)},
                completion: nil)
            
            /* Show corresponding view */
            if(sender.tag == 1){
                self.showCollapseView1();
            }
            else if(sender.tag == 2){
                self.showCollapseView2();
            }
            else if(sender.tag == 3){
                self.showCollapseView3();
            }
        }
  
    }

    
    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

}
