//
//  URLConvertible.swift
//  Navigator
//
//  Created by 工作 on 2019/8/15.
//  Copyright © 2019 aksskas. All rights reserved.
//

import Foundation

public protocol URLConvertible {
    
    var urlValue: URL? { get }
    
    var urlStringValue: String { get }
    
    var queryParameters: [String: String] { get }
    
    var queryItems: [URLQueryItem]? { get }
}

extension URLConvertible {
    
    public var queryParameters: [String: String] {
        return urlValue?.queryParameters ?? [:]
    }
    
    public var queryItems: [URLQueryItem]? {
        return URLComponents(string: urlStringValue)?.queryItems
    }
}

extension String: URLConvertible {
    
    public var urlValue: URL? {
        
        if let url = URL(string: self) { return url }
        return addingPercentEncoding(withAllowedCharacters: .urlAllowed).flatMap{ URL(string: $0) }
    }
    
    public var urlStringValue: String {
        return self
    }
}

extension URL: URLConvertible {
    public var urlValue: URL? {
        return self
    }
    
    public var urlStringValue: String {
        return absoluteString
    }
}

extension URL {
    
    public var queryParameters: [String: String]? {
        
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems else { return nil }
        
        var params: [String: String] = [:]
        
        queryItems.forEach {
            params[$0.name] = $0.value
        }
        return params
    }
    
}

fileprivate extension CharacterSet {
    
    static let urlAllowed: CharacterSet = {
        var set = CharacterSet()
        set.formUnion(.urlHostAllowed)
        set.formUnion(.urlPathAllowed)
        set.formUnion(.urlQueryAllowed)
        set.formUnion(.urlFragmentAllowed)
        return set
    }()
    
}
