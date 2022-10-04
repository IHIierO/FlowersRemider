//
//  PinterestLayoutDelegate.swift
//  FlowersReminder
//
//  Created by Artem Vorobev on 03.10.2022.
//

import Foundation

protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}
