//
//  AddEntryViewController.swift
//  PictureDiary
//
//  Created by Flatiron School on 7/6/16.
//  Copyright © 2016 theMan. All rights reserved.
//

import UIKit
import CoreData

class AddEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var picker: UIImagePickerController!

    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            entryImage.image = image as? UIImage
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func pickTapped(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            picker.sourceType = .PhotoLibrary
            picker.modalPresentationStyle = .FullScreen
        }
        presentViewController(picker, animated: true, completion: nil)

    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        //saved tapped for now...
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("PhotoEntry", inManagedObjectContext: managedContext)
        let entry = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let convertedImg = UIImagePNGRepresentation((entryImage?.image)!)
        
        entry.setValue(convertedImg, forKey: "image")
        entry.setValue(textField.text!, forKey: "entry")
        entry.setValue(NSDate(), forKey: "date")
        
        do {
            try managedContext.save()
            dismissViewControllerAnimated(true, completion: nil)
            print("SAVED the entity")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }

    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
   
    
}

