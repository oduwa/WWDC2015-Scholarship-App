//
//  TextPopupViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 22/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class TextPopupViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        /* Text View Setup */
        self.textView.text = SwiftAppUtils.sharedInstance.currentInterestText;
        self.textView.backgroundColor = SwiftAppUtils.sharedInstance.currentInterestColour;
        self.textView.font = UIFont(name: "AvenirNext-Regular", size: 20.0);
        
        /* Center text in Text View */
        var topCorrect : CGFloat = (self.textView.bounds.height - self.textView.contentSize.height * self.textView.zoomScale)/2.0;
        println(self.textView.bounds.height);
        println(self.textView.contentSize.height);
        println(self.textView.zoomScale)
        println(topCorrect)
        topCorrect = topCorrect < 0 ? 0 : 560/2;
        self.textView.contentOffset = CGPointMake(0, topCorrect);
        //self.textView.textAlignment = NSTextAlignment.Center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
