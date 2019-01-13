/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {

  // MARK: IB Outlets

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!

  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!

  let info = UILabel()

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // Call animation methods here
    animateForm()
  }
  
  override func viewWillLayoutSubviews() {
    animateInfo()
  }

  // MARK:- Animation Methods
  func animateForm() {
    // 1 - Create the animation object
    let flyRight = CABasicAnimation(keyPath: keyPath.positionX)
    flyRight.fromValue = -view.bounds.size.width / 2
    flyRight.toValue = view.bounds.size.width / 2
    flyRight.duration = 0.5
    
//    flyRight.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    // Pattern 2
//    flyRight.timingFunction = CAMediaTimingFunction(
//      controlPoints: 0.11, 1, 0.83, 0.67
//    )
    
    // Pattern 3
    flyRight.timingFunction = CAMediaTimingFunction(
      controlPoints: 0.99, 0, 0, 0.99
    )
    
    // This line's going to affect the whole animation from flyRight
//    flyRight.speed = 0.25
    flyRight.fillMode = kCAFillModeBackwards
    
    let infoGroup = CAAnimationGroup()
    infoGroup.beginTime = CACurrentMediaTime() + 0.5
    infoGroup.duration = 10.0
    infoGroup.fillMode = kCAFillModeBackwards
    infoGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    let flyLeft = CABasicAnimation(keyPath: keyPath.positionX)
    flyLeft.fromValue = info.layer.position.x + view.frame.size.width
    flyLeft.toValue = info.layer.position.x
    
    let fadeLabelIn = CABasicAnimation(keyPath: keyPath.opacity)
    fadeLabelIn.fromValue = 0.0
    fadeLabelIn.toValue = 1.0
    fadeLabelIn.duration = 5.0
    
    infoGroup.animations = [flyLeft, fadeLabelIn]
    info.layer.add(infoGroup, forKey: nil)
    
    // Without CAAnimationGroup
//    let flyLeft = CABasicAnimation(keyPath: keyPath.positionX)
//    flyLeft.fromValue = info.layer.position.x + view.frame.size.width
//    flyLeft.toValue = info.layer.position.x
//    flyLeft.duration = 10.0
//
//    let fadeLabelIn = CABasicAnimation(keyPath: keyPath.opacity)
//    fadeLabelIn.fromValue = 0.0
//    fadeLabelIn.toValue = 1.0
//    fadeLabelIn.duration = 5.0
    
    // 2 - Add the animation to a layer
    heading.layer.add(flyRight, forKey: nil)
    
    flyRight.beginTime = CACurrentMediaTime() + 0.3
    username.layer.add(flyRight, forKey: nil)
    
    flyRight.beginTime = CACurrentMediaTime() + 0.5
    password.layer.add(flyRight, forKey: nil)
    info.layer.add(flyLeft, forKey: nil)
    info.layer.add(fadeLabelIn, forKey: nil)
    
    // 3 - Update the layer model
  }
  
  func animateLoginButton() {
    // 1 - Create a CAAnimationGroup
    let groupAnimation = CAAnimationGroup()
    groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5
    groupAnimation.duration = 0.5
    groupAnimation.fillMode = kCAFillModeBackwards
    
    // 2 - Create the animations you want to group
    let scaleDown = CABasicAnimation(keyPath: keyPath.transformScale)
    scaleDown.fromValue = 3.5
    scaleDown.toValue = 1.0
    
    let rotate = CABasicAnimation(keyPath: keyPath.transformRotation)
    rotate.fromValue = CGFloat.pi / 4
    rotate.toValue = 0.0
    
    let fade = CABasicAnimation(keyPath: keyPath.opacity)
    fade.fromValue = 0.0
    fade.toValue = 1.0
    
    // 3 - Set the group's animations property and add it to the layer you want to animate
    groupAnimation.animations = [scaleDown, rotate, fade]
    loginButton.layer.add(groupAnimation, forKey: nil)
  }

  func animateInfo() {
    // Add text info
    info.frame = CGRect(x: 0.0, y: loginButton.center.y + 30.0,  width: view.frame.size.width, height: 30)
    info.backgroundColor = UIColor.clear
    info.font = UIFont(name: "HelveticaNeue", size: 12.0)
    info.textAlignment = .center
    info.textColor = UIColor.white
    info.text = "Tap on a field and enter username and password"
    view.insertSubview(info, belowSubview: loginButton)
  }

  @IBAction func login() {
    let startColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
    let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
    
    let tint = CABasicAnimation(keyPath: keyPath.backgroundColor)
    tint.fromValue = startColor.cgColor
    tint.toValue = tintColor.cgColor
    
    // Just animating the presentation layer which is just a copy of the layer
    // The bg color is not actually changed
    loginButton.layer.add(tint, forKey: nil)
    // Actually change the bg color to persist the color even after the animation has finished
    loginButton.layer.backgroundColor = tintColor.cgColor
    
    delay(seconds: 4, completion: {
      self.loginButton.layer.backgroundColor = startColor.cgColor
      tint.fromValue = tintColor.cgColor
      tint.toValue = startColor.cgColor
      self.loginButton.layer.add(tint, forKey: nil)
    })
  }
}

//MARK:- UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {}
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }
}

//MARK:- A delay function
func delay(seconds: Double, completion: @escaping ()-> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

//MARK:- Animation keyPaths
enum keyPath {
  static let backgroundColor = "backgroundColor"
  static let opacity = "opacity"
  static let position = "position"
  static let positionX = "position.x"
  static let positionY = "position.y"
  static let shadowOffset = "shadowOffset"
  static let shadowOpacity = "shadowOpacity"
  static let transformRotation = "transform.rotation"
  static let transformScale = "transform.scale"
}
