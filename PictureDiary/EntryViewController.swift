//
//  EntryViewController.swift
//  PictureDiary
//
//  Created by Flatiron School on 7/5/16.
//  Copyright © 2016 theMan. All rights reserved.
//

import UIKit
import CoreData

class EntryViewController: UIViewController {

    @IBOutlet weak var diaryEntryText: UITextView!
    @IBOutlet weak var entryImage: UIImageView!
    
    var entry: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBlur()
        diaryEntryText.text = entry.valueForKey("entry") as? String

        let imageData = entry.valueForKey("image") as? NSData
        entryImage.image = UIImage(data:imageData!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBlur() {
        view.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.bounds
        
//        view.addSubview(visualEffectView)
        view.insertSubview(visualEffectView, atIndex: 0)
        
//        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
//        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
////        vibrancyView.contentView.addSubview(self)
//        visualEffectView.contentView.addSubview(vibrancyView)
        
    
    }

    @IBAction func closeActionTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
