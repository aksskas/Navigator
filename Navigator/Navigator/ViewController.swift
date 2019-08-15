//
//  ViewController.swift
//  Navigator
//
//  Created by 工作 on 2019/8/15.
//  Copyright © 2019 aksskas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var btn1: UIButton = {
        $0.setTitle("test1", for: .normal)
        $0.backgroundColor = .blue
        return $0
    }( UIButton() )
    
    private lazy var btn2: UIButton = {
        $0.setTitle("test2", for: .normal)
        $0.backgroundColor = .blue
        return $0
    }( UIButton() )
    
    private lazy var btn3:  UIButton = {
        $0.setTitle("safari", for: .normal)
        $0.backgroundColor = .blue
        return $0
    }( UIButton() )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn3.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[btn1(80)]", options: [], metrics: nil, views: ["btn1": btn1]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[btn1(30)]", options: [], metrics: nil, views: ["btn1": btn1]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[btn2(80)]-100-|", options: [], metrics: nil, views: ["btn2": btn2]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[btn2(30)]", options: [], metrics: nil, views: ["btn2": btn2]))

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[btn3(80)]-160-|", options: [], metrics: nil, views: ["btn3": btn3]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-260-[btn3(30)]", options: [], metrics: nil, views: ["btn3": btn3]))
        
        btn1.addTarget(self, action: #selector(didClickBtn), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(didClickBtn), for: .touchUpInside)
        btn3.addTarget(self, action: #selector(didClickBtn), for: .touchUpInside)
    }

    @objc
    private func didClickBtn(btn: UIButton) {
        if btn == btn1 {
            ExampleNavigator.go("navigator://open?type=test1&title=test1")
        } else if btn == btn2 {
            ExampleNavigator.go("navigator://open?type=test2&title=test2")
        } else if btn == btn3 {
            ExampleNavigator.go("https://www.baidu.com")
        }
    }
}
