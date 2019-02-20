//
//  MainPageViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 11/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//
import UIKit

class MainPageViewController: UIPageViewController{
    
    //ARRAY CON LOS VIEW CONTROLLERS
    lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "intro1"),
            self.getViewController(withIdentifier: "intro2"),
            self.getViewController(withIdentifier: "intro3")]
    }()
    
    //DECLARACIÓN DE LOS PUNTITOS DE ABAJO
    var pageControl = UIPageControl()
    
    
    /*************************************************************/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        configurePageControl()
        
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        
        let button = UIButton(frame: CGRect(x:0, y: UIScreen.main.bounds.maxY - 90, width: UIScreen.main.bounds.width, height: 70))
        button.backgroundColor = .white
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:#selector(toNextArticle), for: .touchUpInside)
        button.layer.backgroundColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0).cgColor
        button.tintColor = UIColor.white
        
        self.view.addSubview(button)
        
    }
    
    /**************************************************************/
    
    @objc func toNextArticle(){
        
        let current = self.pageControl.currentPage + 1
        if current >= 3 {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introNav")
            self.present(controller, animated:true, completion: nil)
            return
        }
        
        setViewControllers([pages[current]], direction: .forward, animated: true, completion: nil)
        self.pageControl.currentPage = current
    }
    
    //        guard let currentViewController = self.viewControllers?.first else {
    //            return
    //        }
    //
    //        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else {
    //            return
    //        }
    //
    //        print(pageControl.currentPage)
    //
    //        if (pageControl.currentPage == pages.count - 1) {
    //            let viewController = UIStoryboard (name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as! HomeViewController
    //
    //                self.present(viewController, animated: true, completion: nil)
    //            return
    //        }
    //
    //        setViewControllers([nextViewController], direction: .forward, animated: true, completion: { completed in self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: completed) })
    //    }
    
    func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x:0, y: UIScreen.main.bounds.maxY - 150, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0)
        self.pageControl.pageIndicatorTintColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0)
        self.view.addSubview(pageControl)
    }
}
/********************************************************************************/

//DELEGATE
extension MainPageViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.index(of: pageContentViewController)!
    }
}

//DATASOURCE
extension MainPageViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return pages.last
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of:viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard  nextIndex < pages.count else {
            //guard pages.count != nextIndex else {
            return pages.first
        }
        
        guard pages.count > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
}

