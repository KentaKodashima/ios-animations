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
