//
//  AppContentIntroVC.swift
//  AppIntroDemo
//
//  Created by Pawan kumar on 11/08/18.
//  Copyright © 2018 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

class AppContentIntroVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imgViewWalkThrough: UIImageView!
    
    var pageIndex: Int?
    var page: IntroPageModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Methods
    private func initializeView() {
        if self.pageIndex != nil {
            let image:UIImage? = UIImage.init(named: page.backgroundImageName) 
            self.imgViewWalkThrough.image = image
        }
    }
}
