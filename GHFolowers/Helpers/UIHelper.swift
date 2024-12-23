//
//  UIHelper.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 23.12.2024.
//
import UIKit

struct UIHelper {
    static func createThreeColumnLayout(width: CGFloat) -> UICollectionViewFlowLayout {
        let columns: CGFloat = 3
        let wight = width
        let minItemSpace: CGFloat = 10
        let padding: CGFloat = 12
        let itemWight: CGFloat = (wight - padding * 2 - minItemSpace * 2) / columns
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWight, height: itemWight + 40)
        layout.minimumLineSpacing = minItemSpace
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
        return layout
    }
}
