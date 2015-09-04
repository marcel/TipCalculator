//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Marcel Molina on 9/3/15.
//  Copyright © 2015 Marcel Molina. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
  @IBOutlet weak var lowTipField: UITextField!
  @IBOutlet weak var mediumTipField: UITextField!
  @IBOutlet weak var highTipField: UITextField!
  
  var userPreferences: UserPreferences!
  
  let availableLocales = [
    "en_US": NSLocale(localeIdentifier: "en_US"),
    "en_UK": NSLocale(localeIdentifier: "en_UK")
  ]
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    userPreferences = UserPreferences()
  }
  
  @IBAction func updateDefaultTipValues(textField: UITextField) {
    if let newDefaultTipValue = (submittedTipValue(textField.text)) {
      switch textField.tag {
      case 1:
        userPreferences.lowTipPercentage = newDefaultTipValue
      case 2:
        userPreferences.mediumTipPercentage = newDefaultTipValue
      case 3:
        userPreferences.highTipPercentage = newDefaultTipValue
      default:
        ()
      }
      
      userPreferences.save()
    }
  }
    
  func submittedTipValue(text: String?) -> Int? {
    return text.flatMap { Int($0) }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateTipFields()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    updateTipFields()
  }
  
  override func viewWillDisappear(animated: Bool) {
    print("Will disapear")
    for field in [lowTipField, mediumTipField, highTipField] {
      field.endEditing(true)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func updateTipFields() {
    lowTipField.text    = String(userPreferences.lowTipPercentage)
    mediumTipField.text = String(userPreferences.mediumTipPercentage)
    highTipField.text   = String(userPreferences.highTipPercentage)
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    print("Selected row at \(indexPath)")
  }
  
  
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
    super.prepareForSegue(segue, sender: sender)
    userPreferences.save()
  }
}
