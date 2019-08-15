//
//  ExampleNavigator.swift
//  Navigator
//
//  Created by 工作 on 2019/8/15.
//  Copyright © 2019 aksskas. All rights reserved.
//

import Foundation
import SafariServices

enum ExampleNavigator {
    
    private static let router = Router()
    
    static func register() {
        router.register("http://", webHandlerFactory)
        router.register("https://", webHandlerFactory)
        
        router.register("navigator://open", appHandlerFactory)
    }
    
    @discardableResult
    static func go(_ url: URLConvertible?) -> Bool {
        return router.open(url)
    }
    
    // http
    static func webHandlerFactory(url: URLConvertible) -> Bool {
        guard let url = url.urlValue else { return false  }
        return router.present(SFSafariViewController(url: url))
    }
    
    // app
    static func appHandlerFactory(url: URLConvertible) -> Bool {
        guard let type = url.queryParameters["type"] else { return false }
        switch type {
        case "test1":
            let test1Vc = Test1ViewController()
            test1Vc.title = url.queryParameters["title"]
            return router.push(test1Vc)
        case "test2":
            let test2Vc = Test2ViewController()
            test2Vc.title = url.queryParameters["title"]
            return router.push(test2Vc)
        default:
            return false
        }
    }
    
}
