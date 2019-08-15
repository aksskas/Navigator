//
//  UIViewController+Extension.swift
//  Navigator
//
//  Created by 工作 on 2019/8/15.
//  Copyright © 2019 aksskas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private class var sharedApplication: UIApplication? {
        return UIApplication.perform(NSSelectorFromString("sharedApplication"))?.takeUnretainedValue() as? UIApplication
    }
    
    public class var topMost: UIViewController? {
        guard let currentWindows = sharedApplication?.windows, !currentWindows.isEmpty else { return nil }
        
        var rootViewController: UIViewController?
        for window in currentWindows {
            if let windowRootViewController = window.rootViewController, window.isKeyWindow {
                rootViewController = windowRootViewController
                break
            }
        }
        return topMost(of: rootViewController)
    }
    
    private class func topMost(of viewController: UIViewController?) -> UIViewController? {
        
        // presentedViewController
        if let presentedViewController = viewController?.presentedViewController {
            return topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return topMost(of: pageViewController.viewControllers?.first)
        }
        
        // Child View Controller
        if let childViewController = childViewController(of: viewController?.view) {
            return topMost(of:childViewController)
        }
        
        return viewController
    }
    
    private class func childViewController(of view: UIView?) -> UIViewController? {
        guard let view = view else { return nil }
        for subView in view.subviews.reversed() {
            if let childViewController = subView.next as? UIViewController {
                return childViewController
            } else {
                return childViewController(of: subView)
            }
        }
        return nil
    }
}

