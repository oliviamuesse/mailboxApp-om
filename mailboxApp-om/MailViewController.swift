//
//  MailViewController.swift
//  mailboxApp-om
//
//  Created by Olivia Muesse on 9/28/14.
//  Copyright (c) 2014 Olivia Muesse. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {

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
    @IBOutlet weak var listView: UIImageView!
    
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        rescheduleView.alpha = 0
        resetMessage()
    }

    @IBAction func onTapList(sender: UITapGestureRecognizer) {
        listView.alpha = 0
        resetMessage()
    }
    
    func resetMessage () {
        messageView.frame.origin.x = 0
        messageView.frame.origin.y = 0
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.feedView.frame.origin.y = 143
            self.scrollView.contentSize = CGSizeMake(320, 1352)
            }) { (finished: Bool) -> Void in
                self.delay(0.2) {
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        self.messageView.alpha = 1
                        self.messageView.frame.origin.x = 0
                        self.feedView.frame.origin.y = 229
                        self.scrollView.contentSize = CGSizeMake(320, 1438)
                    })
                }
        }
    }
    
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
        rescheduleView.alpha = 0
        listView.alpha = 0
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
            
            //Swipe right, see green
            if imageCenter.x >= 220 && imageCenter.x < 280 {
                self.archiveIcon.center.x = translation.x - 30
                showArchiveIcon()
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.42, green:0.78, blue:0.19, alpha:1.0)
                })
            
            //Swipe right, see red
            } else if imageCenter.x >= 280 && location.x < 320 {
                self.deleteIcon.center.x = translation.x - 30
                showDeleteIcon()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.81, green:0.16, blue:0.05, alpha:1.0)
                })
            
            //Swipe left see yellow
            } else if imageCenter.x <= 100 && imageCenter.x > 10 {
                self.laterIcon.center.x = translation.x + 350
                showLaterIcon()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.95, green:0.76, blue:0.25, alpha:1.0)
                })
            
            //Swipe left see brown
            } else if imageCenter.x <= 10 && imageCenter.x > -120  {
                self.listIcon.center.x = translation.x + 350
                showListIcon()
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor(red:0.42, green:0.29, blue:0.25, alpha:1.0)
                })
            } else {
                hideIcons()
                containerView.backgroundColor = UIColor(white:0.87, alpha:1.0)
            }
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            hideIcons()
            
            //Send green
             if velocity.x > 0 && imageCenter.x >= 220 && imageCenter.x < 280 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = 480
                })
            
            //send red
            } else if velocity.x > 0 && imageCenter.x >= 280 && imageCenter.x < 480 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageView.center.x = 480
                }) { (finished: Bool) -> Void in
                    self.resetMessage()
                }
            
            //Send yellow
            } else if velocity.x < 0 && imageCenter.x <= 100 && imageCenter.x > 10 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = -320
                })
                UIView.animateWithDuration(0.6, animations: {
                    self.rescheduleView.alpha = 1
                })
            
                //Send brown
            } else if velocity.x < 0 && imageCenter.x <= 10 && imageCenter.x > -120 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = -320
                })
                UIView.animateWithDuration(0.6, animations: {
                    self.listView.alpha = 1
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
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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
