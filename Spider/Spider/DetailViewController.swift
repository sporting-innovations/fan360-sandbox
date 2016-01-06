//
//  DetailViewController.swift
//  Spider
//
//  Created by Bryan Stober on 1/5/16.
//  Copyright © 2016 Bryan Stober Design. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var primaryNameLabel: UILabel!
    @IBOutlet weak var startDatelabel: UILabel!
    @IBOutlet weak var secondaryTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    var detailItem: Event? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            
            if let descLabel = self.descriptionLabel {
                descLabel.text = detail.desc
                
            }
            
            if let pNLabel = self.primaryNameLabel {
                pNLabel.text = detail.primaryName
            }
            
            if let sDlabel = self.startDatelabel {
                sDlabel.text = detail.startDateTime?.stringFromDate(nil)
                
            }
            
            if let sTLabel = self.secondaryTitleLabel {
                sTLabel.text = detail.secondaryName
                
            }
            
            if let imageView = self.customImageView {
                imageView.image = ImageHelper.sharedInstance.loadImageFromPath("\(detail.imageName!).\(detail.imageType!)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

