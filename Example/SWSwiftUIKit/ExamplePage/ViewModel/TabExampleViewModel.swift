//
//  TabViewModel.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/15.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation


class TabExampleViewModel: ObservableObject {
    @Published var tabViewModel: SWTabPageViewModel<TabViewModel, TabContentViewModel>?
    
    init() {
        let tabViewModels = [TabViewModel(title: "tab1"), TabViewModel(title: "tab2"), TabViewModel(title: "tab3")]
        let contentViewModels = [TabContentViewModel(color: .red), TabContentViewModel(color: .blue), TabContentViewModel(color: .gray)]
        tabViewModel = SWTabPageViewModel(tabViewModels: tabViewModels, contentViewModels: contentViewModels)
    }
}

class TabViewModel: SWTabItemProtocol {
    var title: String
    @Published var isSelected: Bool = false
    
    init(title: String) {
        self.title = title
    }
}

class TabContentViewModel: SWTabContentProtocol {
    var color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    //第一次跳转没有数据，请求数据
    func requestDataIfNeeded() {
    }
}
