//
//  MailViewController.swift
//  mailboxApp-om
//
//  Created by Olivia Muesse on 9/28/14.
//  Copyright (c) 2014 Olivia Muesse. All rights reserved.
//

import UIKit

class MailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navView: UIImageView!
    @IBOutlet weak var helpView: UIImageView!
    @IBOutlet weak var searchView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    
    func hideIcons () {
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
    }
    
    func showArchiveIcon () {
        archiveIcon.alpha = 1
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
    }
    
    func showDeleteIcon () {
        archiveIcon.alpha = 0
        deleteIcon.alpha = 1
        laterIcon.alpha = 0
        listIcon.alpha = 0
    }

    func showLaterIcon () {
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        laterIcon.alpha = 1
        listIcon.alpha = 0
    }

    func showListIcon () {
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(320, 1438)
        hideIcons ()
        scrollView.delegate = self
        rescheduleView.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanContainer(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        var imageCenter = messageView.center
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            imageCenter = messageView.center
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageView.center.x = translation.x + 160
            
            //Swipe right, see red
            if imageCenter.x >= 220 && imageCenter.x < 280 {
                self.archiveIcon.center.x = translation.x - 30
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.42, green:0.78, blue:0.19, alpha:1.0)
                    self.showArchiveIcon()
                })
            
            //Swipe right, see green
            } else if imageCenter.x >= 280 && location.x < 320 {
                self.deleteIcon.center.x = translation.x - 30
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.81, green:0.16, blue:0.05, alpha:1.0)
                    self.showDeleteIcon()
                })
            
            //Swipe left see yellow
            } else if imageCenter.x <= 100 && imageCenter.x > 10 {
                self.laterIcon.center.x = translation.x + 350
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.95, green:0.76, blue:0.25, alpha:1.0)
                    self.showLaterIcon()
                })
            
            //Swipe left see brown
            } else if imageCenter.x <= 10 && imageCenter.x > -120  {
                self.listIcon.center.x = translation.x + 350
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.42, green:0.29, blue:0.25, alpha:1.0)
                    self.showListIcon()
                })
            } else {
                hideIcons()
                containerView.backgroundColor = UIColor(white:0.87, alpha:1.0)
            }
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            hideIcons()
            
            //Send red
            if velocity.x > 0 && imageCenter.x >= 220 && imageCenter.x < 280 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = 480
                    self.containerView.backgroundColor = UIColor(red:0.42, green:0.78, blue:0.19, alpha:1.0)
                })
            
            //Send green
            } else if velocity.x > 0 && imageCenter.x >= 280 && location.x < 320 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = 480
                    self.containerView.backgroundColor = UIColor(red:0.81, green:0.16, blue:0.05, alpha:1.0)
                })
            
            //Send yellow
            } else if velocity.x < 0 && imageCenter.x <= 100 && imageCenter.x > 10 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = -320
                    self.containerView.backgroundColor = UIColor(red:0.95, green:0.76, blue:0.25, alpha:1.0)
                })
                UIView.animateWithDuration(0.6, animations: {
                    self.rescheduleView.alpha = 1
                })
                //self.performSegueWithIdentifier("rSegue", sender: self)
            
                //Send brown
            } else if velocity.x < 0 && imageCenter.x <= 10 && imageCenter.x > -120 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = -320
                    self.containerView.backgroundColor = UIColor(red:0.42, green:0.29, blue:0.25, alpha:1.0)
                })
                
            //Back to gray
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = 160
                    self.containerView.backgroundColor = UIColor(white:0.87, alpha:1.0)
                })
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
