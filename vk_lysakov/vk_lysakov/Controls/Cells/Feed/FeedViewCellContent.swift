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
    private lazy var photoImageView = UIImageView()
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
        if images?.count == 1 {
//            photoImageView.image = images[0]
            addSubview(photoImageView)
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint .activate([
                photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
                photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
                photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
                photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        } else {
            let lt = UICollectionViewFlowLayout()
            lt.scrollDirection = .horizontal
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
    }
    
    // MARK:UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { images?.count ?? 0 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        cell.imageView.image = images?[indexPath.row]
        return cell
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