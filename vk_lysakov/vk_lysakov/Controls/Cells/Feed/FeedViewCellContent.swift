import UIKit

class FeedViewCellContent: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var images: [UIImage]? {
        didSet {
            if let i = images {
                if i.count < 4 {
                    itemsPerRow = CGFloat(i.count)
                }
            }
        }
    }
    var parentView: UIView?
    
    private var collectionView: UICollectionView?
    private var itemsPerRow: CGFloat = 4
    private let sectionInserts = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        
        let lt = UICollectionViewFlowLayout()
        lt.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: lt)
        if let cv = collectionView {
            cv.backgroundColor = .systemBackground
            cv.register(NewsViewCell.self, forCellWithReuseIdentifier: "NewsViewCell")
            self.addSubview(cv)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.delegate = self
            cv.dataSource = self
            NSLayoutConstraint .activate([
                cv.topAnchor.constraint(equalTo: self.topAnchor),
                cv.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                cv.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                cv.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
        }
        
    }
    
    // MARK:UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { images?.count ?? 0 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        cell.imageView.image = images?[indexPath.item]
        return cell
    }
    
    private var imageView = UIImageView()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BigPhotoViewController()
        vc.view.frame = parentView!.convert(parentView!.frame, to: parentView)
        vc.transitioningDelegate = vc
        vc.modalPresentationStyle = .custom
        vc.startFrame = collectionView.convert(collectionView.layoutAttributesForItem(at: indexPath)!.frame, to: parentView?.superview)
        vc.view.backgroundColor = .systemBackground
        vc.imageView.image = images?[indexPath.item]
        parentViewController?.present(vc, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = (collectionView.frame.width - sectionInserts.left * (itemsPerRow + 1)) / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}
