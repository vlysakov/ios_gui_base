import UIKit

class FeedsNewsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let data = TestData.data.users
    let reuseIdentifier = "FeedViewCell"
    let itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    fileprivate let collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lt)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.register(FeedViewCell.self, forCellWithReuseIdentifier: "FeedViewCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = .lightGray
        NSLayoutConstraint .activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    
    // MARK:UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { data.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedViewCell
        cell.headerView.fullNameLabel.text = data[indexPath.item].fullName
        cell.headerView.profileImageView.image = data[indexPath.item].avatar
        cell.contentsView.images = data[indexPath.item].fotos.map {UIImage(named: $0.name)!}
//        data[indexPath.item].fotos.forEach{
//            cell.contentsView.images.append(UIImage(named: $0.name)!)
//        }
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

