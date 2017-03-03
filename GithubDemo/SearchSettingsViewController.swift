//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by JS on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

class SearchSettingsViewController: UIViewController {

    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var starValue: UILabel!
    var stars: Int?
    
    weak var delegate: SettingsPresentingViewControllerDelegate?
    var existingSettings: GithubRepoSearchSettings!

    var settings: GithubRepoSearchSettings! {
        didSet {
            existingSettings = settings
            stars = settings.minStars
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starSlider.minimumValue = 0
        starSlider.maximumValue = 1000000
        starValue.text = "\(stars!)"
        starSlider.value = Float(stars!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSliderChange(_ sender: Any) {
        stars = Int(starSlider.value)
        self.starValue.text = "\(stars!)"
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.delegate?.didCancelSettings()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        settings.minStars = stars!
        self.delegate?.didSaveSettings(settings: settings)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
