import UIKit

class AnimateController: UIViewController {

    @IBOutlet weak var greenImage: UIView!
    @IBOutlet weak var redImage: UIView!
    @IBOutlet weak var blueImage: UIView!
    @IBOutlet weak var cloudView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greenImage.cornerRadius = greenImage.frame.height / 2
        redImage.cornerRadius = redImage.frame.height / 2
        blueImage.cornerRadius = blueImage.frame.height / 2
        blueImage.isHidden = true
        redImage.isHidden = true
        greenImage.isHidden = true
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = UIColor.systemBackground.cgColor
        shapeLayer.lineWidth = 2
        cloudView.layer.addSublayer(shapeLayer)
        shapeLayer.path = cloudPath().cgPath
        shapeLayer.strokeEnd = 1
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 5
        shapeLayer.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5),
                                      execute: { self.performSegue(withIdentifier: "TabSegue", sender: nil)

        })
    }
    
    let strokeColor = UIColor.black
    let shapeLayer = CAShapeLayer()
    
    private func cloudPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 19.47, y: 24.04))
        bezierPath.addCurve(to: CGPoint(x: 17.9, y: 25.51), controlPoint1: CGPoint(x: 19.47, y: 24.77), controlPoint2: CGPoint(x: 18.68, y: 25.51))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 47.16), controlPoint1: CGPoint(x: 7.87, y: 26.43), controlPoint2: CGPoint(x: 0, y: 35.78))
        bezierPath.addCurve(to: CGPoint(x: 20.06, y: 69), controlPoint1: CGPoint(x: 0, y: 59.27), controlPoint2: CGPoint(x: 8.85, y: 69))
        bezierPath.addLine(to: CGPoint(x: 96.17, y: 69))
        bezierPath.addCurve(to: CGPoint(x: 118, y: 45.88), controlPoint1: CGPoint(x: 108.17, y: 69), controlPoint2: CGPoint(x: 118, y: 58.54))
        bezierPath.addCurve(to: CGPoint(x: 97.55, y: 22.94), controlPoint1: CGPoint(x: 118, y: 33.77), controlPoint2: CGPoint(x: 108.95, y: 23.67))
        bezierPath.addCurve(to: CGPoint(x: 95.78, y: 21.47), controlPoint1: CGPoint(x: 96.76, y: 22.94), controlPoint2: CGPoint(x: 95.97, y: 22.39))
        bezierPath.addCurve(to: CGPoint(x: 67.65, y: 0), controlPoint1: CGPoint(x: 93.22, y: 9.18), controlPoint2: CGPoint(x: 81.42, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 45.43, y: 9.91), controlPoint1: CGPoint(x: 58.61, y: 0), controlPoint2: CGPoint(x: 50.54, y: 3.85))
        bezierPath.addCurve(to: CGPoint(x: 43.27, y: 10.64), controlPoint1: CGPoint(x: 44.84, y: 10.64), controlPoint2: CGPoint(x: 43.86, y: 10.83))
        bezierPath.addCurve(to: CGPoint(x: 36.78, y: 9.54), controlPoint1: CGPoint(x: 41.3, y: 9.91), controlPoint2: CGPoint(x: 39.14, y: 9.54))
        bezierPath.addCurve(to: CGPoint(x: 19.47, y: 24.04), controlPoint1: CGPoint(x: 27.73, y: 9.36), controlPoint2: CGPoint(x: 20.26, y: 15.78))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        bezierPath.stroke()
        return bezierPath
    }
    

}
