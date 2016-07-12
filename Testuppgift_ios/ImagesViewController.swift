//
//  FirstViewController.swift
//  Testuppgift_ios
//
//  Created by Paul Griffin on 12/07/16.
//  Copyright © 2016 Paul. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadImagesButtonPressed(sender: AnyObject) {
        imageView1.loadImageFromUrl(NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Steve_Jobs_with_red_shawl_edit2.jpg/440px-Steve_Jobs_with_red_shawl_edit2.jpg")!)
        imageView2.loadImageFromUrl(NSURL(string: "https://pbs.twimg.com/profile_images/378800000483764274/ebce94fb34c055f3dc238627a576d251.jpeg")!)
        imageView3.loadImageFromUrl(NSURL(string: "http://assets.rollingstone.com/assets/images/story/20130718-bill-gates-624x420-1374261123.jpg")!)
        imageView4.loadImageFromUrl(NSURL(string: "http://networthier.com/wp-content/uploads/2016/04/Satya-Nadella-net-worth.jpg")!)
        
    }

}

