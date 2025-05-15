//
//  SWTabPageViewModel.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/4/24.
//

import Foundation
import SwiftUI
import Combine

public protocol SWTabItemProtocol: ObservableObject & Identifiable {
    var isSelected: Bool { get set }
}

public protocol SWTabContentProtocol: ObservableObject & Identifiable {
    func requestDataIfNeeded()
}

public class SWTabPageViewModel<TabItemViewModel: SWTabItemProtocol, ContentViewModel: SWTabContentProtocol>: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var selectedIndex: Int = 0 {
        didSet {
            guard selectedIndex != oldValue else {
                return
            }
            updateSelection()
        }
    }
    let tabViewModels: [TabItemViewModel]
    let contentViewModels: [ContentViewModel]
    
    public init(tabViewModels: [TabItemViewModel], contentViewModels: [ContentViewModel]) {
        self.tabViewModels = tabViewModels
        self.contentViewModels = contentViewModels
        self.$selectedIndex.sink(receiveValue: {[unowned self] in
            self.contentViewModels[$0].requestDataIfNeeded()
        }).store(in: &cancellables)
        updateSelection()
    }
    
    private func updateSelection() {
        withAnimation {
            for (i, tab) in tabViewModels.enumerated() {
                tab.isSelected = (i == selectedIndex)
            }
        }
    }
}
