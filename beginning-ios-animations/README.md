#  Beginning iOS Animations

## Animation Basic
Use the UIView.animate method to animate. The simplest form of this method takes two parameters which are duration and animation closure.

**NOTE:** Everytime you use animate(), you should call layoutIfNeeded() to force update the UI status.

```
UIView.animate(
  withDuration: 1.0,
  animations: {
  	layoutIfNeeded()
  }
)
```

### Animate constraints
Animate layoutIfNeeded().

```
    menuHeightConstraint.constant = menuIsOpen ? 200 : 80
    
    UIView.animate(
      withDuration: 0.33,
      delay: 0.0,
      options: .curveEaseIn,
      animations: {
        self.view.layoutIfNeeded()
      },
      completion: nil
    )
```

### Change title
In the example below, `self.view.layoutIfNeeded()` trys to update the label's bounds with `.curveEaseIn` animation. Therefore, `view.layoutIfNeeded()` should be called right after the lable's logic in order to keep it updated.

```
    titleLabel.text = menuIsOpen ? "Select Item!!!!!!!!!!" : "Packing List"
    view.layoutIfNeeded()
    
    UIView.animate(
      withDuration: 0.33,
      delay: 0.0,
      options: .curveEaseIn,
      animations: {
        self.view.layoutIfNeeded()
      },
      completion: nil
    )
```
### Animating Multiplier
Multiplier is get-only value. You cannot just change the value directly.
```
// This is impossible
myConstant.multiplier = 0.5
```
The approach to modify the multiplier is as below.  
1. Find the constraint you want to animate using view.constraints.
2. Disable the constraint
3. Create and activate the new constraint
```
view.constraints.forEach { constraint in
  if constraint.identifier == "🐱width" {
    constraint.isActive = false

    let newConstraint = NSLayoutConstraint()
    newConstraint.isActive = true
  }
}
```

### Transitioning
#### Transitioning Triggers
- isHidden (Hiding)
- addSubview() (Unhiding)
- removeFromSuperview()

#### Methods
##### View to view
The `with: UIView` attribute needs a containerView.

```
UIView.transition(
  with: UIView,
  duration: TimeInterval,
  options: UIView.AnimationOptions,
  animations: (() -> Void)?,
  completion: ((Bool) -> Void)?
)
```
##### ViewController to view
```
UIView,transition(
  from: UIViewController,
  to: UIViewController,
  duration: TimeInterval,
  options: UIView.AnimationOptions,
  animations: (() -> Void)?,
  completion: ((Bool) -> Void)?
)
```

**NOTE:**
Use `.allowUserInteraction` option to allow user interantion while transitioning or animating.

### Animate properties
**Position & Size**

- bounds
- frame
- center

**Transformation**

- rotation
- scale
- translation

**Appearance**

- backgroundColor
- alpha

#### Fade one background image into another smoothly
1. Add invisible helper view on top of background view
2. Fade helper view in
3. Update background view and remove helper view

#### Teansform property
1. Rotation: CGAffineTransform(rotationAngle: -.pi/5)
2. Scale: CGAffineTransform(scaleX: 1.25, y: 1.25)
3. Translation: CGAffineTransform(translation: translationX: 0.0, y: 20.0)

**NOTE:** .identity: Reseting all values

#### A label fades in and current label fades out
1. Add an invisible temp label below the real label
2. Translate temp label up and fade it in. Translate real label down and fade it out.
3. Update & reset real label. Remove the temp label.

#### Keyframe animations
A seires of sub-animations that are composed into a single complex animation.
Sub-animations' duration is relative to the whole keyframe animation's duration