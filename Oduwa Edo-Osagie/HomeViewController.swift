//
//  HomeViewController.swift
//  OduwaEdo-Osagie
//
//  Created by Odie Edo-Osagie on 16/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit





class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var mirroredWindow : UIWindow!
    var mirroredScreen : UIScreen!
    var mirroredView : UIView!
    var splashView : SplashView!
    var isExternalScreenConnected : Bool!;
    
    var HOME_SECTION_WIDTH = UIScreen.mainScreen().bounds.width
    var HOME_SECTION_HEIGHT = UIScreen.mainScreen().bounds.width
    
    var currentXPosition : CGFloat!
    var canvas : UIView!
    var introTapGestureRecognizer : UITapGestureRecognizer!
    var leftSectionColour: UIColor!
    var rightSectionColour: UIColor!
    
    var helloLabel : UILabel!
    var tvLabel : UILabel!
    var shimmeringView : FBShimmeringView!
    var firstTapHappened = false;
    var isIntroHappening = true;
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Register for notifications */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("centerOnPersonal"), name: kCenterOnPersonal, object: nil);
        
        /* Setup constants */
        if(SwiftAppUtils.isIOS8OrHigher()){
            HOME_SECTION_WIDTH = UIScreen.mainScreen().bounds.width;
            HOME_SECTION_HEIGHT = UIScreen.mainScreen().bounds.height
        }
        else{
            HOME_SECTION_WIDTH = UIScreen.mainScreen().bounds.height;
            HOME_SECTION_HEIGHT = UIScreen.mainScreen().bounds.width
        }
        
        /* Nav bar customisation */
        self.navigationController?.navigationBarHidden = true;
        
        
        /* Scroll View Setup */
        self.scrollView.contentSize = CGSizeMake(HOME_SECTION_WIDTH*3, HOME_SECTION_HEIGHT);
        self.scrollView.center = self.view.center;
        self.view.backgroundColor = UIColor.blackColor();
        self.scrollView.setContentOffset(CGPointMake(HOME_SECTION_WIDTH, scrollView.contentOffset.y), animated: false);
        self.currentXPosition = self.scrollView.contentOffset.x;
        if(!SwiftAppUtils.sharedInstance.sharedMotionManager.accelerometerAvailable){
            // allow manual scrolling
            println("ACCELEROMETER UNAVAILABLE");
            self.scrollView.scrollEnabled = true;
        }
        else{
            // disallow manual scrolling
            println("ACCELEROMETER AVAILABLE");
            self.scrollView.scrollEnabled = false;
        }
        
        self.scrollView.delegate = self;
        
        /* Start Intro */
        if(SwiftAppUtils.isIOS8OrHigher()){
            self.initializeIntroViews();
        }
        
        /* Register for screen notifications */
        var center : NSNotificationCenter = NSNotificationCenter.defaultCenter();
        center.addObserver(self, selector: Selector("screenDidConnect:"), name: UIScreenDidConnectNotification, object: nil);
        center.addObserver(self, selector: Selector("screenDidDisconnect:"), name: UIScreenDidDisconnectNotification, object: nil);
        center.addObserver(self, selector: Selector("screenModeDidChange:"), name: UIScreenModeDidChangeNotification, object: nil);
        
        self.checkForExistingExternalScreenAndInitialize()
        
        /* Hide Page Control. comment this out to add page control functionality */
        pageControl.hidden = true;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.setupViews();
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        /* Tilt setup */
        if(!isIntroHappening){
            self.setupAccelerometerNavigation();
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        
        /* Stop Tilt */
        SwiftAppUtils.sharedInstance.sharedMotionManager.stopAccelerometerUpdates();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAccelerometerNavigation(){
        SwiftAppUtils.sharedInstance.sharedMotionManager.deviceMotionUpdateInterval = 0.5;
        SwiftAppUtils.sharedInstance.sharedMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (accelData, error) -> Void in
            var a = accelData.acceleration;
            
            var incrementStep : CGFloat = 4;
            
            if(a.y > 0.2 && self.currentXPosition >= incrementStep){
                self.currentXPosition = self.currentXPosition - incrementStep;
                self.scrollView.setContentOffset(CGPointMake(self.currentXPosition, self.scrollView.contentOffset.y), animated: false);
            }
            else if(a.y < -0.2 && self.currentXPosition <= (self.HOME_SECTION_WIDTH*2)-2){
                self.currentXPosition = self.currentXPosition + incrementStep;
                self.scrollView.setContentOffset(CGPointMake(self.currentXPosition, self.scrollView.contentOffset.y), animated: false);
            }
        });
    }
    
    
    // MARK: Page Setup
    
    func setupViews(){
        var centerView : UIView = UIView(frame: CGRectMake(HOME_SECTION_WIDTH, 0, HOME_SECTION_WIDTH, HOME_SECTION_HEIGHT));
        centerView.backgroundColor = UIColor.cyanColor();
        self.scrollView.addSubview(centerView);
        self.setupCenterHomeView();

        var leftView : UIView = UIView(frame: CGRectMake(0, 0, HOME_SECTION_WIDTH, HOME_SECTION_HEIGHT));
        leftView.backgroundColor = UIColor.magentaColor();
        self.scrollView.addSubview(leftView);
        self.setupLeftHomeView();
        
        var rightView : UIView = UIView(frame: CGRectMake(HOME_SECTION_WIDTH*2, 0, HOME_SECTION_WIDTH, HOME_SECTION_HEIGHT));
        rightView.backgroundColor = UIColor.yellowColor();
        self.scrollView.addSubview(rightView);
        self.setupRightHomeView();
        
        if(splashView == nil){
            splashView = SplashView.instanceFromNib() as! SplashView;
        }
    }
    
    
    func setupCenterHomeView(){
        var c  = CenterHomeView.instanceFromNib() as! CenterHomeView;
        c.frame = CGRectMake(HOME_SECTION_WIDTH, 0, HOME_SECTION_WIDTH, HOME_SECTION_HEIGHT)
        c.setup();
        
        c.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.scrollView.addSubview(c);
        
        /* Top Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: c, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0));
        
        /* Bottom Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: c, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: HOME_SECTION_HEIGHT));
        
        /* Right Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: c, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: HOME_SECTION_WIDTH*2));
        
        /* Left Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: c, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: HOME_SECTION_WIDTH));
        
        /* Link Center view to "Personal" page */
        c.moreButton.addTarget(self, action: Selector("moreButtonPressed"), forControlEvents: UIControlEvents.TouchUpInside);
        //c.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("moreButtonPressed")));
    }
    
    func setupLeftHomeView(){
        var r  = RightHomeView.instanceFromNib() as! RightHomeView;
        r.frame = CGRectMake(0, 0, HOME_SECTION_WIDTH, HOME_SECTION_HEIGHT)
        r.setup();
        
        r.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.scrollView.addSubview(r);
        
        /* Top Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: r, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0));
        
        /* Bottom Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: r, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: HOME_SECTION_HEIGHT));
        
        /* Right Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: r, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: HOME_SECTION_WIDTH));
        
        /* Left Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: r, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0));
        
        /* Touch gesture */
        r.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapProjectSection")));
        
        leftSectionColour = r.backgroundColor;
    }
    
    func setupRightHomeView(){
        var l  = LeftHomeView.instanceFromNib() as! LeftHomeView;
        l.frame = CGRectMake(0, 0, HOME_SECTION_WIDTH, HOME_SECTION_HEIGHT)
        l.setup();
        
        l.setTranslatesAutoresizingMaskIntoConstraints(false);
        self.scrollView.addSubview(l);
        
        /* Top Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: l, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0));
        
        /* Bottom Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: l, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: HOME_SECTION_HEIGHT));
        
        /* Right Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: l, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: HOME_SECTION_WIDTH*3));
        
        /* Left Constraint */
        self.scrollView.addConstraint(NSLayoutConstraint(item: l, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: HOME_SECTION_WIDTH*2));
        
        /* Touch gesture */
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapInterestsSection")));
        
        rightSectionColour = l.backgroundColor;
    }
    
    
    // MARK: Scroll View
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //var scrollPercent = floor((self.scrollView.contentOffset.x/self.scrollView.frame.width)*100.0);
        if(self.scrollView.contentOffset.x < (HOME_SECTION_WIDTH-HOME_SECTION_WIDTH*2/3) && self.scrollView.contentOffset.x > 0){
            pageControl.currentPage = 0;
            self.scrollView.backgroundColor = leftSectionColour;
            self.splashView.filterView.backgroundColor = leftSectionColour;
            self.splashView.filterView.alpha = 1.0;
        }
        else if(self.scrollView.contentOffset.x > (HOME_SECTION_WIDTH-HOME_SECTION_WIDTH*2/3) && self.scrollView.contentOffset.x < (HOME_SECTION_WIDTH*2*2/3)){
            pageControl.currentPage = 1;
            self.splashView.filterView.backgroundColor = UIColor.whiteColor();
            self.splashView.filterView.alpha = 1.0;
        }
        else if(self.scrollView.contentOffset.x >= (self.scrollView.frame.width*1.5/3)){
            pageControl.currentPage = 2;
            self.scrollView.backgroundColor = rightSectionColour;
            self.splashView.filterView.backgroundColor = rightSectionColour;
            self.splashView.filterView.alpha = 1.0;
        }
    }
    
    // MARK: AirPlay
    
    func checkForExistingExternalScreenAndInitialize() -> Bool {
        if(UIScreen.screens().count > 1){
            var mainScreen = UIScreen.mainScreen();
            for aScreen in UIScreen.screens() {
                if (aScreen as! UIScreen != mainScreen) {
                    // Found an external screen. Initialize it !
                    self.initializeWindowForScreen(aScreen as! UIScreen);
                    return true;
                }
            }
            
            return false;
        }
        else{
            return false;
        }
    }
    
    func initializeWindowForScreen(screen: UIScreen){
        isExternalScreenConnected = true;
        self.mirroredScreen = screen;
        
        // Find max resolution
        var max : CGSize = CGSizeZero;
        var maxScreenMode : UIScreenMode!;
        
        for current in self.mirroredScreen.availableModes {
            if (maxScreenMode == nil || current.size.height > max.height || current.size.width > max.width) {
                max = current.size;
                maxScreenMode = current as! UIScreenMode;
            }
        }
        
        self.mirroredScreen.currentMode = maxScreenMode;
        
        // Create 2nd window
        var screenBounds = self.mirroredScreen.bounds;
        self.mirroredWindow = UIWindow(frame: screenBounds);
        self.mirroredWindow.screen = self.mirroredScreen;
        self.mirroredWindow.backgroundColor = UIColor.whiteColor();
        self.mirroredWindow.layer.contentsGravity = kCAGravityResizeAspect;
        
        self.displayViewOnScreen(screenBounds);
        
        // Show the window.
        self.mirroredWindow.hidden = false;
    }
    
    func displayViewOnScreen(withBounds: CGRect){
        // Clear window
        if(self.mirroredView != nil){
            self.mirroredView.removeFromSuperview();
        }
        
        // Create view to display
        self.mirroredView = UIView(frame: withBounds);
        self.mirroredView.backgroundColor = UIColor.whiteColor();
        self.mirroredWindow.addSubview(mirroredView);
        
        // Content View
        splashView = SplashView.instanceFromNib() as! SplashView;
        splashView.frame = withBounds;
        splashView.setup();
        self.splashView.filterView.alpha = 1.0;
        self.mirroredView.addSubview(splashView);
        
    }
    
    func screenDidConnect(notification: NSNotification){
        isExternalScreenConnected = true;
        var screen : UIScreen = notification.object as! UIScreen;
        self.initializeWindowForScreen(screen);
    }
    
    func screenDidDisconnect(notification: NSNotification){
        isExternalScreenConnected = false
        self.disableMirroringOnCurrentScreen();
    }
    
    func screenModeDidChange(notification: NSNotification){
        var screen : UIScreen = notification.object as! UIScreen;
        self.disableMirroringOnCurrentScreen();
        self.initializeWindowForScreen(screen);
        isExternalScreenConnected = true;
    }
    
    func disableMirroringOnCurrentScreen(){
        self.mirroredView.removeFromSuperview();
        self.mirroredView = nil;
        self.mirroredScreen = nil;
        self.mirroredWindow = nil;
    }
    
    
    
    // MARK: Intro animations
    
    func initializeIntroViews(){
        /* Canvas */
        canvas = UIView(frame: CGRectMake(0,0,HOME_SECTION_WIDTH,HOME_SECTION_HEIGHT));
        canvas.backgroundColor = UIColor.whiteColor();
        let window : UIWindow = UIApplication.sharedApplication().keyWindow!;
        window.addSubview(canvas);
        
        /* Shimmer */
        shimmeringView = FBShimmeringView(frame: self.view.bounds);
        helloLabel = UILabel(frame: shimmeringView.bounds);
        tvLabel = UILabel(frame: shimmeringView.bounds);
        
        /* "Welcome" text */
        helloLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 42.0);
        helloLabel.textAlignment = NSTextAlignment.Center;
        helloLabel.text = "Welcome!";
        helloLabel.sizeToFit();
        var helloTextHeight = helloLabel.bounds.height;
        shimmeringView.contentView = helloLabel;
        canvas.addSubview(shimmeringView);
        helloLabel.center = CGPointMake(window.center.x, -helloLabel.frame.height);
        
        /* "AppleTV" text */
        if(HOME_SECTION_HEIGHT > 480){
            tvLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 30.0);
        }
        else{
            tvLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 22.0);
        }
        tvLabel.textAlignment = NSTextAlignment.Center;
        tvLabel.text = "Please connect an AppleTV if you have one";
        tvLabel.sizeToFit();
        var tvTextHeight = helloLabel.bounds.height;
        tvLabel.alpha = 0;
        //tvLabel.center = CGPointMake(window.center.x, -tvLabel.frame.height);
        
        
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.helloLabel.center = window.center;
        }) { (success) -> Void in
            /* Button/Arrow */
            var button : UIButton = UIButton(frame: CGRectMake(0, 0, 50, 50));
            button.center = CGPointMake(window.center.x, window.center.y+(helloTextHeight/2)+15);
            button.setImage(UIImage(named: "accordion"), forState: UIControlState.Normal);
            button.alpha = 0.0;
            self.canvas.addSubview(button);
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                button.alpha = 1.0;
            }, completion: { (success) -> Void in
                /* Start label shimmering */
                self.shimmeringView.shimmering = true;
                
                /* Make arrow hop up and down */
                UIView.animateKeyframesWithDuration(1, delay: 0, options: UIViewKeyframeAnimationOptions.Autoreverse | UIViewKeyframeAnimationOptions.Repeat, animations: { () -> Void in
                    UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1, animations: { () -> Void in
                        button.center = CGPointMake(button.center.x, button.center.y+10);
                    })
                    }, completion: nil);
                
                /* Add tap gesture recognizer */
                if(self.introTapGestureRecognizer == nil){
                    self.introTapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("introCanvasTapped"));
                    self.canvas.addGestureRecognizer(self.introTapGestureRecognizer);
                    println("ADD")
                }
            })
        }
    }
    
    // MARK: Selectors
    
    func moreButtonPressed(){
        self.performSegueWithIdentifier("showPersonal", sender: self);
    }
    
    func didTapProjectSection(){
        self.performSegueWithIdentifier("showProjects", sender: self);
    }
    
    func didTapInterestsSection(){
        var storyboard : UIStoryboard = UIStoryboard(name: "rubber", bundle: nil);
        var i : PortraitNavigationViewController = storyboard.instantiateViewControllerWithIdentifier("interestsNavigationController") as! PortraitNavigationViewController;
        self.presentViewController(i, animated: true, completion: nil);
    }
    
    func introCanvasTapped(){
        /* Prevent double taps, which might crash the app if timed perfectly */
        self.canvas.userInteractionEnabled = false;
        
        if(firstTapHappened == false){
            /* Show second mesage */
            shimmeringView.contentView = tvLabel;
            tvLabel.center = tvLabel.center;//CGPointMake(window.center.x, -helloLabel.frame.height);
            
            UIView.animateWithDuration(2.0, animations: { () -> Void in
                self.helloLabel.alpha = 0;
                }) { (success) -> Void in
                    
                    UIView.animateWithDuration(2.0, animations: { () -> Void in
                        self.tvLabel.alpha = 1;
                        }) { (success) -> Void in
                            self.firstTapHappened = true;
                            self.canvas.userInteractionEnabled = true;
                            self.isIntroHappening = false;
                            self.setupAccelerometerNavigation();
                    }
            }
        }
        else{
            /* Remove intro screen */
            UIView.animateWithDuration(2.0, animations: { () -> Void in
                self.canvas.alpha = 0;
                }) { (success) -> Void in
                    self.canvas.userInteractionEnabled = true;
                    self.canvas.removeFromSuperview();
            }
        }
        
        
    }
    
    // MARK: Helpers
    
    func centerOnPersonal(){
        self.scrollView.scrollRectToVisible(CGRectMake(HOME_SECTION_WIDTH, 0, HOME_SECTION_WIDTH, HOME_SECTION_HEIGHT), animated: false);
    }
    
    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    
}
