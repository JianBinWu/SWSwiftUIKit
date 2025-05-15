//
//  CarouselExampleViewModel.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/15.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class CarouselExampleViewModel: ObservableObject {
    let views: [Color] = [.blue, .red, .yellow, .green]
    @Published var carouselViewModel: SWCarouselViewModel
    
    @MainActor
    init() {
        carouselViewModel = SWCarouselViewModel(itemCount: 4)
    }
}
