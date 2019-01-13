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

## Peek & Pop Animation
### Preparing views for animating
1. Make a copy of the icon with a snapshot
2. Create an effect view with some texts, and make it the same size of the icon and fade out the texts
3. Position both the effect view and the snapshot on the top of the icon

### Preparing animation itself
1. The peek animation is started by scaling the effect view up and the rotation begins part way through
2. The pop animation will finish the animation off by scaling the effect view back to its original size, fading the texts in, and moving it just above the icon

## Animation State Machine
- isRunning (true/false) read-only
- isReversed (true/false)
- state (.active/.inactive/.stoped) 

### .inactive to .active
- startAnimation()
- pauseAnimation()
- fractionComplete()
- animations complete naturally

### .active to .stoped
- stopAnimation()

### .stoped to .inactive
- finishAnimation(at:)

## Views VS. Layers
### Views
Views are more complex.

- complex view hierarchy
- responds to user input
- constraints, resize masks, etc.

### Layers
- simpler layer hierarchy
- drawn directly on the GPU (better performance and flexibility)

## Layer Animations
View level animations + layer level animations.
### View level animations
- bounds
- position
- transform

### Layer level animations
- borderColor
- borderWidth
- cornerRadius

## CABasicAnimation
```
// Update layer model
// heading is an UILabel
heading.layer.position.x = -view.bounds.size.width/2

// Create animation
let flyRight = CABasicAnimation(keyPath: "position.x")
flyRight.fromValue = -view.bounds.size.width/2
flyRight.toValue = view.bounds.size.width/2
flyRight.duration = 0.5

Send animation to GPU
heading.layer.add(flyRight, forKey: nil) 
```

## Core Animation
### API part
- addAnimation()
- removeAllAnimations()

### Core Animation Server
Runs out side of and in parallel to your app. It tals directly to GPU.

### Layer Trees
#### Model layer tree
What your app sees.

#### Presentation layer tree
What is actually on screen

## Layer Animation Delay
### Strategy
Using CABasicAnimation's beginTime property and CACurrentMediaTime(), implement flow would be as below.

1. Get current time (CACurrentMediaTime())
2. Add an amount of delay time
3. Set animation begin time (beginTime)
4. Set animation end time

### Fill Modes
- Fill Backwards:

   Before the beginTime property. `kCAFillModeBackwards` will fill up the time before the animation begins.
   
- Fill Forwards: 

   After the animation ends
   
## CAAnimationGroup
You can set all of the shared properties and group itself, then add animations you want to group together.