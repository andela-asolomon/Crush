//
//  ViewController.swift
//  DemoInsta
//
//  Created by Ayoola Solomon on 7/7/15.
//  Copyright (c) 2015 Ayoola Solomon. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, GPPSignInDelegate {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Applying blurry effect to bg image
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        bgImage.addSubview(blurEffectView)
        
        signInButton.layer.cornerRadius = 5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authenticateWithGoogle() {
        var signIn = GPPSignIn.sharedInstance()
        signIn.shouldFetchGooglePlusUser = true
        signIn.clientID = Google["consumerKey"]
        signIn.scopes = ["email"]
        signIn.delegate = self
        signIn.authenticate()
    }
    
    func lol(auth: GTMOAuth2Authentication!, error: NSError!) {
        if error != nil {
            ProgressHUD.showError("Error")
            showAlertView("Error", message: "\(error.localizedDescription)")
        } else {
            let ref = Firebase(url: "https://mecrush.firebaseio.com/")
            
            ref.authWithOAuthProvider("google", token: auth.accessToken, withCompletionBlock: { (error, authData) -> Void in
                if error != nil {
                    ProgressHUD.showError("Error")
                    self.showAlertView("Error", message: "\(error.localizedDescription)")
                } else {
            
                    let userRef = ref.childByAppendingPath("users")
                    
                    var userDict = Dictionary<String, AnyObject>()
                    
                    if let userData = authData.providerData {
                        let id: NSString = userData["id"] as! NSString
                        let name: NSString = userData["displayName"] as! NSString
                        
                        if let userProfile: AnyObject = userData["cachedUserProfile"] {
                            userDict = userProfile as! Dictionary<String, AnyObject>
                            
                            userRef.childByAppendingPath("\(authData.uid)").setValue(userDict)
                            self.performSegueWithIdentifier("timeline", sender: authData)
                            ProgressHUD.showSuccess("Logged in Successful")
                        }
                    }
                }
            })
        }
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        if error != nil {
            ProgressHUD.showError("Error")
            showAlertView("Error", message: "\(error.localizedDescription)")
        } else {
            let ref = Firebase(url: "https://mecrush.firebaseio.com/")
            ref.authWithOAuthProvider("google", token: auth.accessToken, withCompletionBlock: { (error, authData) -> Void in
                if error != nil {
                    ProgressHUD.showError("Error")
                    self.showAlertView("Error", message: "\(error.localizedDescription)")
                } else {
                    
                    let userRef = ref.childByAppendingPath("users")
                    
                    userRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
                        
                        for user in [snapshot.value] {
                            
                            if user[authData.uid] !== nil {
                                self.performSegueWithIdentifier("timeline", sender: authData)
                                ProgressHUD.showSuccess("Logged in Successful")
                                
                            } else {
                                
                                var userDict = Dictionary<String, AnyObject>()
                                
                                if let userData = authData.providerData {
                                    let id: NSString = userData["id"] as! NSString
                                    let name: NSString = userData["displayName"] as! NSString
                                    
                                    if let userProfile: AnyObject = userData["cachedUserProfile"] {
                                        
                                        userDict["name"] = userProfile["name"] as! String
                                        userDict["email"] = userProfile["email"] as! String
                                        userDict["profile"] = userProfile["picture"] as! String
                                        userDict["gender"] = userProfile["gender"] as! String
                                        
                                        userRef.childByAppendingPath("\(authData.uid)").setValue(userDict)
                                        self.performSegueWithIdentifier("timeline", sender: authData)
                                        ProgressHUD.showSuccess("Logged in Successful")
                                    }
                                }
                            }

                            
                        }
                        
                        }, withCancelBlock: { (error) -> Void in
                            println(error)
                    })
                }
            })
        }
    }
    
    @IBAction func SignWithInstagram(sender: AnyObject) {
        ProgressHUD.show("Logging in...", interaction: false)
        authenticateWithGoogle()
    }
    
    
    func showAlertView(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "timeline" {
            if let timelineVc = segue.destinationViewController as? TimelineTableViewController {
                
            }
        }
        
    }
    
}

