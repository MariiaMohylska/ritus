import UIKit

class AwardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return awardsList.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AwardCell", for: indexPath) as! AwardCell
        let award = awardsList[indexPath.item]
        
        cell.awardNotes.text = award.awardNote
        cell.inspirationQuoteLabel.text = award.inspirationQuotes
        
        if let url = URL(string: award.imageURL) {
                    cell.awardImageView.imageFrom(url: url)
        }
        
        return cell
    }
    
    
    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var awardsList: [Award] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        awardsList = Award.getAwards()
        if awardsList.isEmpty{
            collectionView.isHidden = true
            emptyListLabel.isHidden = false
        } else {
            collectionView.isHidden = false
            emptyListLabel.isHidden = true
        }
    }
    
}

extension UIImageView{
    func imageFrom(url:URL){
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }

}
