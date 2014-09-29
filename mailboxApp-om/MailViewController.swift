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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(320, 1438)
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
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
            if velocity.x > 0 {
                containerView.backgroundColor = UIColor.greenColor()
            } else if velocity.x < 0 {
                containerView.backgroundColor = UIColor.yellowColor()
            } else {
                
            }
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
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
