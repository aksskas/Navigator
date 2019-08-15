//
//  Router.swift
//  Navigator
//
//  Created by 工作 on 2019/8/15.
//  Copyright © 2019 aksskas. All rights reserved.
//

import UIKit

public typealias RouterPattern = String
public typealias URLOpenHandlerFactory = (_ url: URLConvertible) -> Bool

public class Router {
    
    private var handlerFactories = [RouterPattern: URLOpenHandlerFactory]()
    
    public func register(_ pattern: RouterPattern, _ factory: @escaping URLOpenHandlerFactory) {
        handlerFactories[pattern] = factory
    }
    
    @discardableResult
    public func open(_ url: URLConvertible?) -> Bool {
        guard let url = url else { return false }
        guard let handler = (handlerFactories.keys.filter{ url.urlStringValue.hasPrefix($0) }.compactMap{ handlerFactories[$0] }).first else { return false }
        return handler(url)
    }
    
    @discardableResult
    public func push(_ viewController: UIViewController, from: UINavigationController? = nil, animated: Bool = true) -> Bool {
        guard !(viewController is UINavigationController) else { return false }
        guard let nav = from ?? UIViewController.topMost?.navigationController else { return false}
        nav.pushViewController(viewController, animated: animated)
        return true
    }
    
    
    @discardableResult
    public func present(_ viewController: UIViewController, form: UIViewController? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> Bool {
        guard let fromViewController = form ?? UIViewController.topMost else { return false }
        fromViewController.present(viewController, animated: animated, completion: completion)
        return true
    }
    
    
    @discardableResult
    public func autoTransition(_ viewController: UIViewController, wrapped: UINavigationController.Type? = nil, from: UIViewController? = nil, animated: Bool = true) -> Bool {
        guard let fromViewController = from ?? UIViewController.topMost else { return false }
        if let nav = fromViewController.navigationController {
            nav.pushViewController(viewController, animated: animated)
        } else {
            if let wrapped = wrapped { // 默认不包装导航控制器
                fromViewController.present(wrapped.init(rootViewController: viewController), animated: animated, completion: nil)
            } else {
                fromViewController.present(viewController, animated: animated, completion: nil)
            }
        }
        return true
    }
    
}

