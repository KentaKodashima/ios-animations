# Inntermediate iOS Animations

## View Animations VS. Property Animations
### View animations

`UIView.animate(withDuration:..)`

- Fire-and-Forget
- Established. simple API

`UIViewPropertyAnimator`

- Interactive
- Interruptible & Reversible
- Adjust Dynamically
- Advanced Timing and Springs

## Using UIViewPropertyAnimator
UIViewPropertyAnimator flow basically would be like this.

```
// Create an animator with a duration and curve
let scale = UIViewPropertyAnimator(
  duration: 0.5,
  curve: .easeIn
)

// Add animations to the animator
scale.addAnimations {
  view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
}

// Add a completion handler if you need one
scale.addCompletion { _ in
  print("All done! 🎉")
}

```
Using `addAnimation()`, you can add as many animations as you want even with different delays.