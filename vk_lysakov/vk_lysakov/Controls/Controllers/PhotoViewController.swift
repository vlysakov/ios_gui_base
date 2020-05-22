import UIKit

class PhotoViewController: UIViewController {

    var photo: User.Photo?
    
    @IBOutlet weak var likeButton: UILikeButton!
    @IBOutlet weak var shareButton: UIShareButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ph = photo {
            photoImageView.image = UIImage(named: ph.name)!
            likeButton.countLike = ph.likeCount
            likeButton.likeStatus = ph.isLiked
            shareButton.sharedImage = photoImageView.image
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        if let ph = photo {
            ph.isLiked = likeButton.likeStatus
            ph.likeCount = likeButton.countLike
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
    }
    
}
