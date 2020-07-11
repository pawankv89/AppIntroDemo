//
//  ViewController.swift
//  AppIntroDemo
//
//  Created by Pawan kumar on 11/08/18.
//  Copyright © 2018 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

class AppIntroVC: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    public lazy var pages: [IntroPageModel] = {
        var pages = [IntroPageModel]()
        pages.append(IntroPageModel.pageModel(
            title: "Keep you device updated",
            subtitle: "Recommendations updated your Device",
            topImageName: "appIntro1",
            backgroundImageName: "walkThrough_1"
        ))
        pages.append(IntroPageModel.pageModel(
            title: "Device Status",
            subtitle: "Check Device Status",
            topImageName: "appIntro2",
            backgroundImageName: "walkThrough_2"
        ))
        pages.append(IntroPageModel.pageModel(
            title: "Solutions",
            subtitle: "Please check your Device & Fixed",
            topImageName: "appIntro3",
            backgroundImageName: "walkThrough_3"
        ))
        return pages
    }()
    
    // MARK: - IBOutlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageControlView: UIView!
    
    //Bottom View
    @IBOutlet weak var pageBottomContentView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLael: UILabel!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var pageController:UIPageViewController!
    var viewControllers:[AppContentIntroVC]!
    
    var currentIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Configuration PageController
        self.configurationPageController()
        
        //Shadow of Bottom View
        //self.pageBottomContentView.layer.shadowColor = UIColor.black.cgColor
        //self.pageBottomContentView.layer.shadowOpacity = 1
        //self.pageBottomContentView.layer.shadowOffset = CGSize.zero
        //self.pageBottomContentView.layer.shadowRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func configurationPageController() -> Void {
        
        pageController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let frame:CGRect = self.pageControlView.bounds
        pageController.view.frame = frame
        
        let appContentIntroVC :AppContentIntroVC = self.viewControllerAtIndex(index: 0)
        viewControllers = [appContentIntroVC]
        currentIndex = 0
        
        //Update AppIntro Details
        self.updateAppIntroViewData(index: 0, viewController: appContentIntroVC)
        
        pageController.dataSource = self
        pageController.delegate = self
        
        pageController.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        self.addChildViewController(pageController)
        self.pageControlView.addSubview(pageController.view)
        
        if pageControl != nil {
            pageControl?.numberOfPages = self.pages.count
            self.view.bringSubview(toFront: pageControl!)
        }
        
    }
    
    /**
     This method returns instance of WalkthroughVC
     - Parameter index: Int
     - Returns    childVC: WalkThroughVC
     */
    private func viewControllerAtIndex(index:Int) -> AppContentIntroVC {
        
        // ByDefault Storyboard has name "Main" if we renamed it then we will pass that name.
        let strybrd: UIStoryboard = UIStoryboard(name: "AppIntro", bundle: Bundle.main)
        let childVC = strybrd.instantiateViewController(withIdentifier: "AppContentIntroVC") as! AppContentIntroVC
        
        self.currentIndex = index
        childVC.pageIndex = index
        childVC.page = self.pages[index]
        

        return childVC
    }
    
    // MARK: - UIPageViewControllerDataSource Methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let walkThroughVC = viewController as? AppContentIntroVC
        
        var index = walkThroughVC?.pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index = index! - 1
        return self.viewControllerAtIndex(index: index!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let walkThroughVC = viewController as? AppContentIntroVC
        
        var index = walkThroughVC?.pageIndex
        let pageCount = self.pages.count
        
        index = index! + 1
        
        if index == pageCount {
            return nil
        }
        return self.viewControllerAtIndex(index: index!)
    }
    
    // MARK: - UIPageViewControllerDelegate Method
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed {
            return
        }
        let childVC = pageViewController.viewControllers?.last as? AppContentIntroVC
        pageControl?.currentPage = (childVC?.pageIndex)!
        
        //Update AppIntro Details
        self.updateAppIntroViewData(index: (childVC?.pageIndex)!, viewController: childVC!)
    }
    
     // MARK: - SKIP Button Tap Method
    
    @IBAction func skipbuttonTap(_ sender: Any) {
        
        //Move to Login Screen
    }
    // MARK: - NEXT Button Tap Method
    
    @IBAction func nextbuttonTap(_ sender: Any) {
        
        if (currentIndex < self.pages.count - 1)
        {
             currentIndex = currentIndex + 1
            let startingViewController :AppContentIntroVC = self.viewControllerAtIndex(index: currentIndex)
            let viewControllers = [startingViewController]
            
            pageController.setViewControllers(viewControllers,
                                              direction: UIPageViewControllerNavigationDirection.forward,
                                              animated: true,
                                              completion: nil)
            
            //Update AppIntro Details
            self.updateAppIntroViewData(index: currentIndex, viewController: startingViewController)
            pageControl?.currentPage = currentIndex
            
        }
    }
    
    //Click on NEXT Button Changed
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func updateAppIntroViewData(index:Int, viewController: AppContentIntroVC) -> Void {
        
        let page = self.pages[index]
        
        //Set Other Title and Image here
        
        self.titleLabel.text? = page.title
        
        self.subtitleLael.text? = page.subtitle
        
        let image:UIImage? = UIImage.init(named: page.topImageName)
        self.topImageView.image = image
        
        //Button Handling here
        if (index < self.pages.count - 1)
        {
             self.skipButton.isHidden = false
             self.nextButton.setTitle("NEXT", for: .normal)
            
        }else{
            
             self.skipButton.isHidden = true
             self.nextButton.setTitle("PROCEED", for: .normal)
        }
    }
}

