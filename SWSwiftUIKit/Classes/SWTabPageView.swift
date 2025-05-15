//
//  SWTabPageView.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/24.
//

import SwiftUI

public struct SWTabPageView<
    TabItemViewModel: SWTabItemProtocol,
    ContentViewModel: SWTabContentProtocol,
    TabItem: View,
    ContentView: View
>: View {
    @ObservedObject var viewModel: SWTabPageViewModel<TabItemViewModel, ContentViewModel>
    let tabViewBuilder: (TabItemViewModel) -> TabItem
    let contentViewBuilder: (ContentViewModel) -> ContentView
    
    public init(viewModel: SWTabPageViewModel<TabItemViewModel, ContentViewModel>, tabViewBuilder: @escaping (TabItemViewModel) -> TabItem, contentViewBuilder: @escaping (ContentViewModel) -> ContentView) {
        self.viewModel = viewModel
        self.tabViewBuilder = tabViewBuilder
        self.contentViewBuilder = contentViewBuilder
    }

    public var body: some View {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.tabViewModels.indices, id: \.self) { index in
                            tabViewBuilder(viewModel.tabViewModels[index])
                                .onTapGesture {
                                    viewModel.selectedIndex = index
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                TabView(selection: $viewModel.selectedIndex) {
                    ForEach(viewModel.contentViewModels.indices, id: \.self) { index in
                        contentViewBuilder(viewModel.contentViewModels[index])
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
    }
}
