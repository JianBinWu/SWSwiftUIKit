//
//  SWCarouselView.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/17.
//

import SwiftUI

public struct SWCarouselView<Content: View>: View {
    @State var views: [Content]
    @ObservedObject var viewModel: SWCarouselViewModel
    
    public init(views: [Content], viewModel: SWCarouselViewModel) {
        self.views = {
            guard views.count > 1 else { return views }
            let first = views.first!
            let last = views.last!
            return [last] + views + [first]
        }()
        self.viewModel = viewModel
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                TabView(selection: $viewModel.currentIndex) {
                    ForEach(views.indices, id: \.self) { index in
                        VStack {
                            views[index]
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
}
