//
//  VC+Delegate+DataSource.swift
//  SwiftUIKitDemo
//
//  Created by SIDDHARTH KOSHIYAR on 10/08/24.
//

import Foundation
import UIKit

// MARK: - 💢 Collection + DataSource 💢
extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.carouselList.count
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.data = vm.carouselList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("calling this layout")
        return collection.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let visibleRect = CGRect(origin: collection.contentOffset, size: collection.bounds.size)
       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
       if let visibleIndexPath = collection.indexPathForItem(at: visiblePoint) {
           self.pageControl.currentPage = visibleIndexPath.row
           vm.setdataList(index: visibleIndexPath.row)
           tableView.reloadData()
       }
    }

}
// MARK: - 💢 UITableView + DataSource 💢
extension ViewController: UITableViewDataSource,UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DataListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.data = vm.dataList[indexPath.row]
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.setFilteredData(searchText: searchText)
        tableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
       self.searchBar.endEditing(true)
    }

    
}
