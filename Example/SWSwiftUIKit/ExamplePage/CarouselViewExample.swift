
//
//  CarouselViewExample.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/14.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct CarouselViewExample: View {
    @ObservedObject var viewModel = CarouselExampleViewModel()
    
    var body: some View {
        ZStack {
            SWCarouselView(views: viewModel.views, viewModel: viewModel.carouselViewModel)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    CarouselIndicator(viewModel: viewModel.carouselViewModel)
                        .frame(width: 100, height: 4)
                        .padding()
                }
            }
        }
        .frame(width: 300, height: 225)
    }
}

#Preview {
    CarouselViewExample()
}
