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
        
        imageView1.loadImageFromUrl(NSURL(string: "http://img.dn.se/remote/d1.dn-static.se/UploadedImages/2016/7/12/aa8e1a21-9f08-437d-9299-2177635298d2/bigOriginal.jpg?preset=AlmaSectionTeaserUncroppedDesktop")!)
        imageView2.loadImageFromUrl(NSURL(string: "http://images-6.svd-cdn.se/v2/images/6172164a-54c1-4692-ba3c-6186b3c43f2f?fit=crop&h=132&q=60&w=211&s=9f38cd998dce69d364a6987a430439bd521228dc")!)
        imageView3.loadImageFromUrl(NSURL(string: "http://gfx.aftonbladet-cdn.se/image/23160925/485/imageColumnDouble/b0889c57c47f1/D7K_2770.JPG")!)
        imageView4.loadImageFromUrl(NSURL(string: "http://z.cdn-expressen.se/images/8c/c7/8cc78772d3534924bb563d71813ab2dc/16x6/560.jpg")!)
        
    }

}

