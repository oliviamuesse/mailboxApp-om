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
                self.deleteIcon.center.x = translation.x - 30
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor.redColor()
                    self.showDeleteIcon()
                })
            //Swipe right, see green
            } else if imageCenter.x >= 280 && location.x < 320 {
                self.archiveIcon.center.x = translation.x - 30
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor.greenColor()
                    self.showArchiveIcon()
                })
            //Swipe left see yellow
            } else if imageCenter.x <= 100 && imageCenter.x > 10 {
                self.laterIcon.center.x = translation.x + 350
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor.yellowColor()
                    self.showLaterIcon()
                })
            //Swipe left see brown
            } else if imageCenter.x <= 10 && imageCenter.x > -120  {
                self.listIcon.center.x = translation.x + 350
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.containerView.backgroundColor = UIColor.brownColor()
                    self.showListIcon()
                })
            } else {
                hideIcons()
                containerView.backgroundColor = UIColor.grayColor()
            }
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            hideIcons()
            if velocity.x > 0 && imageCenter.x >= 220 && imageCenter.x < 280 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = 480
                    self.containerView.backgroundColor = UIColor.redColor()
                })
            } else if velocity.x > 0 && imageCenter.x >= 280 && location.x < 320 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = 480
                    self.containerView.backgroundColor = UIColor.greenColor()
                })

            } else if velocity.x < 0 && imageCenter.x <= 100 && imageCenter.x > 10 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = -320
                    self.containerView.backgroundColor = UIColor.yellowColor()
                })
            } else if velocity.x < 0 && imageCenter.x <= 10 && imageCenter.x > -120 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = -320
                    self.containerView.backgroundColor = UIColor.brownColor()
                })
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = 160
                    self.containerView.backgroundColor = UIColor.grayColor()
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
