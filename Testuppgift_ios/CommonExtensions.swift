//
//  CommonExtensions.swift
//  Testuppgift_ios
//
//  Created by Paul Griffin on 12/07/16.
//  Copyright © 2016 Paul. All rights reserved.
//

import UIKit



enum Response<T> {
    case Success(T)
    case Error(ErrorType)
    
    //Takes a Response<T> and returns Response<G>
    //If the value is .Success then the function trasnform is applied, else the value is returned directly
    func map<G>(transform: T -> Response<G>) -> Response<G> {
        switch self {
        case .Success(let value):
            return transform(value)
        case .Error(let error):
            return .Error(error)
        }
        
    }
}

extension UIView {
    
    func startActivityIndicator(hasNavigationBar hasNavigationBar: Bool = true) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicator.frame = frame
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.didMoveToSuperview()
        activityIndicator.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        activityIndicator.centerYAnchor.constraintEqualToAnchor(centerYAnchor, constant: hasNavigationBar ? -64 : 0).active = true
    }
    
    func stopActivityIndicator() {
        for subview in subviews {
            if let activityIndicator = subview as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
extension UIViewController{
    func dismissKeyboardOnTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PhoneBookViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension NSURL {
    func getData(callback: Response<NSData> -> Void) {
        let url = self
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: url)
        let dataTask = session.dataTaskWithRequest(request) {
            (data, response, error) in
            if let data = data {
                callback(.Success(data))
            } else if let error = error {
                callback(.Error(error))
            } else {
                callback(.Error(NSError(domain: "getData", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unknown error getting data"])))
            }
        }
        dataTask.resume()
    }
    
    func getImage(callback: Response<UIImage> -> Void) {
        getData() {
            callback($0.map({ data -> Response<UIImage> in
                if let image = UIImage(data: data) {
                    return Response<UIImage>.Success(image)
                }
                return Response<UIImage>.Error(NSError(domain: "getImage", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not load image"]))
            }))
        }
    }
}


extension UIImageView {
    //Loads an image asynchronously and sets it to the imageView with an animation.
    //Does all UI work with spinners and displaying error messages
    func loadImageFromUrl(url: NSURL, callback:(Response<UIImage> -> Void)? = nil) {
        hideEmptyMessage()
        startActivityIndicator(hasNavigationBar: false)
        url.getImage() { response in
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.stopActivityIndicator()
                switch response {
                case .Success(let image):
                    UIView.transitionWithView(self, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                        self.image = image
                        }, completion: nil)
                    callback?(.Success(image))
                case .Error(let error):
                    callback?(.Error(error))
                    print(error)
                    self.image = nil
                    self.showEmptyMessage("Failed to load image: \((error as NSError).localizedDescription)", fontSize: 15)
                }
            }
            
        }
    }
}

private let UIViewShowEmptyMessageTag = 93734214

extension UIView {
    func showEmptyMessage(message: String, fontSize: CGFloat = 30) {
        hideEmptyMessage()
        let label = UILabel(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.font = UIFont.systemFontOfSize(fontSize)
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.sizeToFit()
        label.tag = UIViewShowEmptyMessageTag
        label.textColor = UIColor.lightGrayColor()
        label.didMoveToSuperview()
        label.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        label.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        label.widthAnchor.constraintEqualToAnchor(widthAnchor, constant: -40).active = true
    }
    
    func hideEmptyMessage() {
        for view in subviews {
            if view.tag == UIViewShowEmptyMessageTag {
                view.removeFromSuperview()
            }
        }
    }
}