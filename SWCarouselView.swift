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
    
    init(views: [Content], viewModel: SWCarouselViewModel) {
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
                    .simultaneousGesture(
                        DragGesture()
                            .onChanged({ _ in
                                viewModel.stopTimer()
                            })
                            .onEnded({ _ in
                                viewModel.startTimer()
                            })
                    )
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
}

#Preview {
    let models = Mapper<VideoModel>().mapArray(JSONfile: "Data.json")!
    let views = models.map({ model in
        let viewModel = VideoItemViewModel(model: model)
        return CarouselItemView(viewModel: viewModel)
    })
    let viewModel = SWCarouselViewModel(itemCount: views.count)
    ZStack {
        SWCarouselView(views: views, viewModel: viewModel)
        VStack {
            Spacer()
            HStack {
                Spacer()
                CarouselIndicator(viewModel: viewModel)
                    .frame(width: 100, height: 4)
                    .padding()
            }
        }
    }
    .frame(width: 300, height: 225)
    
}
