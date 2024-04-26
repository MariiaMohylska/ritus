import UIKit
//import Nuke

class AwardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
//        return awardsList.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AwardCell", for: indexPath) as! AwardCell
        cell.awardDescription.text = "\(indexPath.item)"
        if imageURL != nil {
            if let url = URL(string: "\(imageURL ?? "")&fit=crop&h=175&w=175") {
//                Nuke.loadImage(with: url, into: cell.awardImageView)
            }
        }
        print("Image url = \(imageURL ?? "")")
        return cell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var awardsList: [Award] = []
    var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AwardsService.fetchImage(){
            image in
            self.imageURL = image?.urls.regular
            self.collectionView.reloadData()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        awardsList = Award.getAwards()
        // Do any additional setup after loading the view.
    }
    
}
