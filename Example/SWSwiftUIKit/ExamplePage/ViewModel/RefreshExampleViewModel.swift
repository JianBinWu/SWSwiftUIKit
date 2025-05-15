//
//  RefreshViewModel.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/14.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class RefreshExampleViewModel: ObservableObject {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    let maxPage = 5
    let pageSize = 10
    @Published var page = 1 {
        didSet {
            DispatchQueue.main.async {
                self.list = (0..<(self.pageSize * self.page)).map { _ in ColorItem(color: .red) }
                self.refreshViewModel.isNoMoreData = self.page == self.maxPage
            }
        }
    }
    @Published var list: [ColorItem]
    var refreshViewModel: SWRefreshableScrollViewModel!
    
    init() {
        list = (0..<self.pageSize).map { _ in ColorItem(color: .red) }
        refreshViewModel = SWRefreshableScrollViewModel(refreshBlock: {
            await self.refresh()
        }, loadMoreBlock: {[unowned self] in
            await self.loadMore()
        })
    }
    
    func refresh() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        await MainActor.run {
            page = 1
            self.list = (0..<self.pageSize).map { _ in ColorItem(color: .red) }
        }
    }
        
    
    func loadMore() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        await MainActor.run {
            self.page += 1
            self.list.append(contentsOf: (0..<self.pageSize).map { _ in ColorItem(color: .red) })
            self.refreshViewModel.isNoMoreData = self.page == self.maxPage
        }
    }
    
}
