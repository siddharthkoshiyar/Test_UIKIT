//
//  ViewModel.swift
//  SwiftUIKitDemo
//
//  Created by SIDDHARTH KOSHIYAR on 10/08/24.
//

import Foundation

class ViewModel {
    
    private(set) var carouselList: [CarouselModel]!
    private(set) var dataList: [ListModel]!
    private(set) var reservedData: [ListModel]!

    init() {
        self.carouselList = [CarouselModel]()
        self.dataList = [ListModel]()
        self.reservedData = [ListModel]()
    }
    
    
    /// This funcation return data from static data
    func setData() {
        self.carouselList = DataModel.carouselData
        if !self.carouselList.isEmpty{
            self.dataList = self.carouselList[0].list
            self.reservedData = self.dataList
        }
    }
    
    func setdataList(index: Int){
        if !self.dataList.isEmpty{
            self.dataList.removeAll()
        }
        self.dataList = self.carouselList[index].list
        self.reservedData = self.dataList
    }
    
    func setFilteredData(searchText: String){
        if !searchText.isEmpty{
            self.dataList = self.reservedData.filter { $0.titleText.contains(searchText) }
        }else{
            self.dataList = self.reservedData
        }
    }
}

