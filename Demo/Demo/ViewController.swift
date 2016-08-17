//
//  ViewController.swift
//  Demo
//
//  Created by LawLincoln on 16/8/16.
//  Copyright © 2016年 LawLincoln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let img = UIImage.ss_combinedShape
		let imgV = UIImageView(frame: CGRectMake(100, 100, 50, 50))
		imgV.image = img
		view.addSubview(imgV)
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

