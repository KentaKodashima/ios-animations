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

// image by NASA: https://www.flickr.com/photos/nasacommons/29193068676/

import UIKit

class LockScreenViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var dateTopConstraint: NSLayoutConstraint!

  let blurView = UIVisualEffectView(effect: nil)
  
  var previewAnimator: UIViewPropertyAnimator?
  var startFrame: CGRect?
  var previewView: UIView?
  let previewEffectView = IconEffectView(blur: .extraLight)

  var settingsController: SettingsViewController!

  override func viewWillAppear(_ animated: Bool) {
    // TODO: Set tableView up for animation
    tableView.transform = CGAffineTransform(scaleX: 0.67, y: 0.67)
    tableView.alpha = 0
    
    dateTopConstraint.constant -= 100
    view.layoutIfNeeded()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    AnimatorFactory.scaleUp(view: tableView).startAnimation()
    
    AnimatorFactory.animateConstraint(
      view: view,
      constraint: dateTopConstraint,
      by: 100
    ).startAnimation()
  }
}

extension LockScreenViewController: WidgetsOwnerProtocol {
  func startPreview(for forView: UIView) {
    previewView?.removeFromSuperview()
    previewView = forView.snapshotView(afterScreenUpdates: false)
    view.insertSubview(previewView!, aboveSubview: blurView)
    
    previewView?.frame = forView.convert(forView.bounds, to: view)
    startFrame = previewView?.frame
    
    previewEffectView.removeFromSuperview()
    previewEffectView.frame = (previewView?.frame)!
    previewView?.superview?.insertSubview(previewEffectView, belowSubview: previewView!)
    
    previewAnimator = AnimatorFactory.grow(view: previewEffectView, blurView: blurView)
  }
  
  func updatePreview(percent: CGFloat) {
    previewAnimator?.fractionComplete = max(0.01, min(0.99, percent))
  }
  
  func cancelPreview() {
    if let previewAnimator = previewAnimator {
      previewAnimator.isReversed = true
      previewAnimator.startAnimation()
      
      previewAnimator.addCompletion { position in
        switch position {
        case .start:
          self.previewView?.removeFromSuperview()
          self.previewEffectView.removeFromSuperview()
        default: break
        }
      }
    }
  }
  
  func finishPreview() {
    previewAnimator?.stopAnimation(false)
    previewAnimator?.finishAnimation(at: .end)
    previewAnimator = nil
    
    AnimatorFactory.complete(view: previewEffectView).startAnimation()
  }
  
  func dismissMenu() {
    // TODO: Create animator to dismiss menu & add completion to clean up
    let reset = AnimatorFactory.reset(
      frame: startFrame!,
      view: previewEffectView,
      blurView: blurView
    )
    
    reset.addCompletion { _ in
      self.previewEffectView.removeFromSuperview()
      self.previewView?.removeFromSuperview()
      self.blurView.isUserInteractionEnabled = false
    }
    
    reset.startAnimation()
  }
}

//////////////////////////
// MARK:- * Starter Code *
//////////////////////////

extension LockScreenViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.bringSubview(toFront: searchBar)
    blurView.isUserInteractionEnabled = false
    view.insertSubview(blurView, belowSubview: searchBar)
    
    tableView.estimatedRowHeight = 130.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    previewEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
  }
  
  override func viewWillLayoutSubviews() {
    blurView.frame = view.bounds
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  @IBAction func presentSettings(_ sender: Any? = nil) {
    //present the view controller
    settingsController = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
    present(settingsController, animated: true, completion: nil)
  }
}

extension LockScreenViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Footer") as! FooterCell
      cell.didPressEdit = {[unowned self] in
        self.presentSettings()
      }
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WidgetCell
      cell.tableView = tableView
      cell.owner = self
      return cell
    }
  }
}
