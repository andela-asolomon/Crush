//
//  ProfileViewController.swift
//  DemoInsta
//
//  Created by Ayoola Solomon on 7/8/15.
//  Copyright (c) 2015 Ayoola Solomon. All rights reserved.
//

import UIKit
import Parse
import Haneke

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var imageButton: UIButton!
    
    let ref = Firebase(url: "https://mecrush.firebaseio.com/")
    let usersRef = Firebase(url: "https://mecrush.firebaseio.com/users")
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.parentViewController?.navigationItem.setHidesBackButton(true, animated: false)
        
        self.parentViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logOut")
        
        imagePicker.delegate = self
        
        username.layer.borderColor = UIColor.grayColor().CGColor
        username.layer.borderWidth = 1.0
        
        name.layer.borderColor = UIColor.grayColor().CGColor
        name.layer.borderWidth = 1.0
        
        bio.layer.borderColor = UIColor.grayColor().CGColor
        bio.layer.borderWidth = 1.0
        
        saveBtn.layer.cornerRadius = 5
        bio.layer.cornerRadius = 5
        name.layer.cornerRadius = 5
        username.layer.cornerRadius = 5
        
        if ref.authData != nil {
            loadUser()
        } else {
            println("Error")
        }
        
        imageButton.layer.masksToBounds = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadUser() {
        
        ref.observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            if let userData: AnyObject = snapshot.value[self.ref.authData.uid] {
                self.name.text = userData["name"] as! String
                if let username = userData["username"] as? String {
                    self.username.text = username
                }
                
                if let bio = userData["bio"] as? String {
                    self.bio.text = bio
                }
                
                if var urlString: String? = userData["profile"] as? String {
                    var url: NSURL? = NSURL(string: urlString!)
                    
                    self.profilePicture.hnk_setImageFromURL(url!)
                }
            }
            }, withCancelBlock: { (error) -> Void in
                println(error.description)
        })
    }
    
    func logOut() {
        ref.unauth()
        let homeVC = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! ViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
        ProgressHUD.showSuccess("Logged Out Successful")
    }
    
    func saveUser() {
        let name = self.name.text
        let bio = self.bio.text
        let username = self.username.text
        if count(name) > 0 && count(bio) > 0 {
            let profileRef = usersRef.childByAppendingPath(self.ref.authData.uid)
            var userDict = Dictionary<String, String>()
            
            userDict["name"] = name
            userDict["username"] = username
            userDict["bio"] = bio
            
            profileRef.updateChildValues(userDict, withCompletionBlock: { (error, ref) -> Void in
                if error != nil {
                    ProgressHUD.showError("Data could not be saved")
                } else {
                    ProgressHUD.showSuccess("Data saved Successfully")
                }
            })
            
        } else {
            
            if self.name.text == "" {
                ProgressHUD.showError("Name field must not be empty")
            } else if self.bio.text == "" {
                ProgressHUD.showError("Bio field must not be empty")
            }
        }
    }
    
    @IBAction func updateProfile(sender: AnyObject) {
        saveUser()
    }


    @IBAction func updateImage(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        var imageManipulation = ImageManipulation()
        let newImage = imageManipulation.RBResizeImage(image, targetSize: CGSize(width: 1280, height: 320))
        
        profilePicture.image = newImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
