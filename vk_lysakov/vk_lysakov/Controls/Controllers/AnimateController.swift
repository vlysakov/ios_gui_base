import UIKit

class AnimateController: UIViewController {

    @IBOutlet weak var greenImage: UIView!
    @IBOutlet weak var redImage: UIView!
    @IBOutlet weak var blueImage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greenImage.cornerRadius = greenImage.frame.height / 2
        redImage.cornerRadius = redImage.frame.height / 2
        blueImage.cornerRadius = blueImage.frame.height / 2
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView .animate(withDuration: 0.6,
                        delay: 0,
                        options: [.repeat, .autoreverse],
                        animations:   { self.blueImage.alpha = 0  })
        UIView .animate(withDuration: 0.8,
                        delay: 0,
                        options: [.repeat, .autoreverse],
                        animations:   { self.redImage.alpha = 0  })
        UIView .animate(withDuration: 1.1,
                        delay: 0,
                        options: [.repeat, .autoreverse],
                        animations:   { self.greenImage.alpha = 0  })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2),
                                      execute: { self.performSegue(withIdentifier: "TabSegue", sender: nil)

        })
    }

}
