//
//  SWRefreshableScrollView.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/29.
//

import SwiftUI

struct SWRefreshableScrollView<Content: View>: View {
    var coordinator = Coordinator()
    var viewModel: SWRefreshableScrollViewModel
    let content: Content
    var showScrollIndicator: Bool
    
    init(coordinator: Coordinator = Coordinator(), showScrollIndicator: Bool = false, viewModel: SWRefreshableScrollViewModel, @ViewBuilder content: () -> Content) {
        self.showScrollIndicator = showScrollIndicator
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.content = content()
        self.coordinator.onReachBottom = {
            guard !viewModel.isLoadingMore, viewModel.canLoadMore, !viewModel.isNoMoreData else { return }
            viewModel.isLoadingMore = true
            Task {
                await viewModel.loadMoreBlock()
                await MainActor.run {
                    viewModel.isLoadingMore = false
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: showScrollIndicator){
            content
            if viewModel.canLoadMore && !viewModel.isNoMoreData && viewModel.isLoadingMore {
                loadMoreView
            }
        }
        .conditionalRefreshable(isEnabled: viewModel.isRefreshable) {
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
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var onReachBottom: (() -> Void)?
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let frameHeight = scrollView.frame.size.height
            if offsetY > (contentHeight - frameHeight) {
                onReachBottom?()
            }
        }
    }
}



extension View {
    @ViewBuilder
    func conditionalRefreshable(isEnabled: Bool, action: @Sendable @escaping () async -> Void) -> some View {
        if isEnabled, #available(iOS 15.0, *) {
            self.refreshable(action: action)
        } else {
            self
        }
    }
}

//#Preview {
//    SWRefreshableScrollView()
//}
