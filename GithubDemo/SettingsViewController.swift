//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Gil Birman on 8/10/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
   func settingsViewController(settingsViewController: SettingsViewController, valueToChange: Settings)
}

class SettingsViewController: UIViewController {



  var delegate: SettingsViewControllerDelegate?

  @IBOutlet weak var starsSlider: UISlider!

  var currentSettings: Settings! {
    didSet{

    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    starsSlider.value = Float(currentSettings.minStars)
    print(currentSettings)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onSave(sender: AnyObject) {
    currentSettings.minStars = Int(starsSlider.value)

    print(currentSettings.minStars)
    
    delegate?.settingsViewController(self, valueToChange: currentSettings!)

    self.dismissViewControllerAnimated(true, completion: nil)
  }

  @IBAction func onCancel(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
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
