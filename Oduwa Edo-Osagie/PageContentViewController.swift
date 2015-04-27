//
//  PageContentViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 20/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    var pageIndex : Int!;
    var bgImageName = "";
    var iconImageName = "";
    var projectName = "";
    var projectDescription = "";
    var projectType = "";
    var downloadLink = "";
    
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var projectIconImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Page Background */
        self.view.alpha = 0.8;
        backgroundImageView.clipsToBounds = true;
        
        /* Description Text Views */
        projectTextView.text = projectDescription;
        self.projectTextView.font = UIFont(name: "GillSans-LightItalic", size: 16.0);
        
        /* Round icon view edges */
        projectIconImageView.layer.borderWidth = 1.0;
        projectIconImageView.layer.borderColor = UIColor.grayColor().CGColor;
        if(projectType == "app"){
            projectIconImageView.layer.cornerRadius = 22.0;
        }
        projectIconImageView.layer.masksToBounds = false;
        projectIconImageView.clipsToBounds = true;
        
        /* iVar Initialization */
        backgroundImageView.image = UIImage(named: bgImageName);
        projectIconImageView.image = UIImage(named: iconImageName);
        projectNameLabel.text = projectName;
        
        /* Back Button */
        var closeButton : UIButton = UIButton(frame: CGRectMake(0, 0, 50, 50));
        closeButton.setImage(UIImage(named: "close"), forState: UIControlState.Normal);
        closeButton.addTarget(self, action: Selector("backButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(closeButton);
        
        /* Screenshot button */
        var screenshotButton : UIButton = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width-50, 0, 50, 50));
        screenshotButton.setImage(UIImage(named: "devices"), forState: UIControlState.Normal);
        screenshotButton.addTarget(self, action: Selector("screenshotButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(screenshotButton);
        
        /* Download button */
        if(!downloadLink.isEmpty){
            var downloadButton : UIButton = UIButton(frame: CGRectMake(screenshotButton.frame.origin.x-50, 0, 50, 50));
            downloadButton.setImage(UIImage(named: "download"), forState: UIControlState.Normal);
            downloadButton.addTarget(self, action: Selector("downloadButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside);
            self.view.addSubview(downloadButton);
        }
        
        /* Text View */
        projectTextView.backgroundColor = UIColor.clearColor();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Selectors
    
    func backButtonPressed(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func screenshotButtonPressed(){
        self.performSegueWithIdentifier("showScreenshots", sender: self);
    }
    
    func downloadButtonPressed(){
        UIApplication.sharedApplication().openURL(NSURL(string: downloadLink)!);
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showScreenshots"){
            let svc: ScreenshotViewController = self.storyboard?.instantiateViewControllerWithIdentifier("screenShotViewController") as! ScreenshotViewController;

            
            let formSheetSegue = segue as! MZFormSheetSegue;
            let formSheet = formSheetSegue.formSheetController;
            formSheet.cornerRadius = 8.0;
            var aspectRatio = SwiftAppUtils.getScreenResolutionSize().height/SwiftAppUtils.getScreenResolutionSize().width;
            
            if(UIScreen.mainScreen().bounds.height == 480){
                aspectRatio  = 16.0/9.0;
                let height = (SwiftAppUtils.getScreenResolutionSize().height*0.8)/UIScreen.mainScreen().scale;
                let width = SwiftAppUtils.calculateWidth(height, andAspectRatio: aspectRatio);
                formSheet.presentedFormSheetSize = CGSizeMake(width, height);
            }
            else{
                let width = (SwiftAppUtils.getScreenResolutionSize().width*0.8)/UIScreen.mainScreen().scale;
                let height = SwiftAppUtils.calculateHeight(width, andAspectRatio: aspectRatio)
                formSheet.presentedFormSheetSize = CGSizeMake(width, height);
                println(width)
                println(height)
            }

            formSheet.transitionStyle = MZFormSheetTransitionStyle.Bounce;
            formSheet.shouldDismissOnBackgroundViewTap = true;

        }
    }
    
    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    

}
