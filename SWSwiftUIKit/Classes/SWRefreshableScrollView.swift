//
//  SWRefreshableScrollView.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/29.
//

import SwiftUI
import SwiftUIIntrospect

public struct SWRefreshableScrollView<Content: View>: View {
    var coordinator = Coordinator()
    @ObservedObject  var viewModel: SWRefreshableScrollViewModel
    let content: Content
    var showScrollIndicator: Bool
    
    public init(coordinator: Coordinator = Coordinator(), showScrollIndicator: Bool = false, viewModel: SWRefreshableScrollViewModel, @ViewBuilder content: () -> Content) {
        self.showScrollIndicator = showScrollIndicator
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.content = content()
        self.coordinator.onReachBottom = {
            guard !viewModel.isLoadingMore, viewModel.canLoadMore, !viewModel.isNoMoreData else { return }
            viewModel.isLoadingMore = true
            Task {
                await viewModel.loadMoreBlock!()
                await MainActor.run {
                    viewModel.isLoadingMore = false
                }
            }
        }
    }
    
    public var body: some View {
        ScrollView(showsIndicators: showScrollIndicator){
            content
            if viewModel.canLoadMore && !viewModel.isNoMoreData && viewModel.isLoadingMore {
                loadMoreView
            }
        }
        .refreshable {
            await viewModel.refreshBlock()
        }
        .introspect(.scrollView, on: .iOS(.v16, .v17, .v18)) { scrollView in
            if viewModel.canLoadMore {
                scrollView.delegate = self.coordinator
            }
            
        }
    }
    
    private var loadMoreView: some View {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    
    public class Coordinator: NSObject, UIScrollViewDelegate {
        var onReachBottom: (() -> Void)?
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let frameHeight = scrollView.frame.size.height
            if offsetY > 0, offsetY > (contentHeight - frameHeight) {
                onReachBottom?()
            }
        }
    }
}
