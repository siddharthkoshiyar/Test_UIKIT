//
//  ViewController.swift
//  SwiftUIKitDemo
//
//  Created by SIDDHARTH KOSHIYAR on 09/08/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    lazy var vm: ViewModel = {
        return ViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerColView()
        registerTableView()
        configureOnViewDidLoad()
    }

    
    private func registerColView() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
        searchBar.delegate = self
        collection.dataSource = self
        collection.delegate = self
        collection.reloadData()
    }
    
    
    private func registerTableView(){
        tableView.register(cellType: DataListCell.self)
        tableView.dataSource = self
        tableView.reloadData()
    }

    func configureCellSize(){
       }
    
    @IBAction func pageControlValueChanges(_ sender: UIPageControl) {
        collection.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        vm.setdataList(index: sender.currentPage)
        tableView.reloadData()
    }
    
    private func configureOnViewDidLoad(){
        vm.setData()
        pageControl.numberOfPages = vm.carouselList.count
        pageControl.backgroundStyle = .prominent
    }
}




// Keyboard Extension
extension ViewController{
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 40.0)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
