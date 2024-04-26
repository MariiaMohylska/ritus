//
//  AwardCell.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/26/24.
//

import UIKit

class AwardCell: UICollectionViewCell {
    
    @IBOutlet weak var awardImageView: UIImageView!
    @IBOutlet weak var inspirationQuoteLabel: UILabel!
    @IBOutlet weak var awardNotes: UILabel!
    @IBOutlet weak var frontView: UIView!
    
       
       var isFlipped = false
       
       override func awakeFromNib() {
           super.awakeFromNib()
           
           // Add tap gesture recognizer
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           self.addGestureRecognizer(tapGesture)
           
           self.layer.cornerRadius = 8
           
           // Hide the back view initially
           awardNotes.isHidden = true
       }
       
       @objc func handleTap() {
           if isFlipped {
               flipToFront()
           } else {
               flipToBack()
           }
       }
       
       private func flipToBack() {
           UIView.transition(from: frontView, to: awardNotes, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
           isFlipped = true
       }
       
       private func flipToFront() {
           UIView.transition(from: awardNotes, to: frontView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
           isFlipped = false
       }
}
