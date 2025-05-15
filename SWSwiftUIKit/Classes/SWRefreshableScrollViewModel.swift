//
//  SWRefreshableScrollViewModel.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/29.
//

import Foundation

public class SWRefreshableScrollViewModel: ObservableObject {
    @Published var canLoadMore: Bool
    @Published public var isNoMoreData = false
    @Published var isLoadingMore = false
    var refreshBlock: (() async ->())
    var loadMoreBlock: (() async ->())?
    
    public init(canLoadMore: Bool = true, refreshBlock: @escaping () async -> Void, loadMoreBlock: (() async -> Void)? = nil) {
        self.canLoadMore = canLoadMore
        self.refreshBlock = refreshBlock
        self.loadMoreBlock = loadMoreBlock
    }
}
