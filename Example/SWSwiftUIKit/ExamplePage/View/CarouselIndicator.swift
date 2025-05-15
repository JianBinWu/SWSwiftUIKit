//
//  CarouselIndicator.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/23.
//

import SwiftUI

struct CarouselIndicator: View {
    @ObservedObject var viewModel: SWCarouselViewModel
    var backgroundColor: Color = Color.white.opacity(0.2)
    var indicatorColor: Color = .white
    
    var body: some View {
        GeometryReader { geometry in
            let count = viewModel.itemCount
            if count > 1 {
                let totalWidth = geometry.size.width
                let indicatorWidth = totalWidth / CGFloat(count)
                let offsetX = indicatorWidth * CGFloat(viewModel.realCurrentIndex)

                ZStack(alignment: .leading) {
                    // Background bar
                    Rectangle()
                        .fill(backgroundColor)
                        .frame(height: 4)

                    // Moving indicator
                    Rectangle()
                        .fill(indicatorColor)
                        .frame(width: indicatorWidth, height: geometry.size.height)
                        .offset(x: offsetX)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.realCurrentIndex)
                }
            }
        }
    }
}
