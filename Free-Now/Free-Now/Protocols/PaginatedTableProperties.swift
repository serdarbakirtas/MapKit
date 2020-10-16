//
//  PaginatedTableProperties.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import UIKit

class PaginatedTableProperties {
    
    let VISIBLE_THRESHOLD = 10
    
    var isRefreshing: Bool
    var isLoadingBySection: [Int: Bool]
    var pageBySection: [Int: Int]
    var totalItemsCountBySection: [Int: Int]
    var loadedItemsCountBySection: [Int: Int]
    var heightAtIndex: [IndexPath: CGFloat]
    
    init() {
        isRefreshing = false
        isLoadingBySection = [0: false]
        pageBySection = [0: 1]
        totalItemsCountBySection = [0: Int.max]
        loadedItemsCountBySection = [:]
        heightAtIndex = [:]
    }
    
    func resetPages() {
        pageBySection.removeAll()
    }
    
    func setRefreshing(isRefreshing: Bool) {
        self.isRefreshing = isRefreshing
    }
    
    func setLoading(section: Int, isLoading: Bool) {
        isLoadingBySection[section] = isLoading
    }
    
    func setCellHeight(at index: IndexPath, height: CGFloat) {
        heightAtIndex[index] = height
    }
    
    func getCellHeight(at index: IndexPath) -> CGFloat? {
        return heightAtIndex[index]
    }
    
    func getPage(section: Int) -> Int {
        pageBySection[section] ?? 1
    }
    
    func setAllSectionsLoading(numberOfSections: Int, isLoading: Bool) {
        for i in 0..<numberOfSections {
            isLoadingBySection[i] = isLoading
        }
    }
    
    func shouldLoadNextPage(index: IndexPath, presentedItemsCount: Int) -> Bool {
        return !isLoadingBySection[index.section]!
            && index.row > presentedItemsCount - VISIBLE_THRESHOLD
            && (isRefreshing || !isAllItemsLoaded(section: index.section))
    }
    
    func increaseLoadedItemsCount(section: Int, by count: Int) {
        loadedItemsCountBySection[section] = (loadedItemsCountBySection[section] ?? 0) + count
    }
    
    func willAllSectionsBeLoaded(section: Int, numberOfSections: Int) -> Bool {
        for i in 0..<numberOfSections where i != section && isLoadingBySection[i] == true {
            return false
        }
        return true
    }
    
    func isAllItemsLoaded(section: Int) -> Bool {
        return getLoadedItemsCount(section: section) >= getTotalItemsCount(section: section)
    }
    
    private func getLoadedItemsCount(section: Int) -> Int {
        return loadedItemsCountBySection[section] ?? 0
    }
    
    private func getTotalItemsCount(section: Int) -> Int {
        return totalItemsCountBySection[section] ?? Int.max
    }
    
    private func setTotalItemsCount(section: Int, count: Int) {
        totalItemsCountBySection[section] = count
    }
    
    private func incrementPage(section: Int) {
        pageBySection[section] = (pageBySection[section] ?? 1) + 1
    }
}
