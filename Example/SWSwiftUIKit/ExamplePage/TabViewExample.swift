//
//  TabViewExample.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/14.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct TabViewExample: View {
    @ObservedObject var viewModel = TabExampleViewModel()
    
    var body: some View {
        SWTabPageView(viewModel: viewModel.tabViewModel!) { viewModel in
            Tab(viewModel: viewModel)
        } contentViewBuilder: { viewModel in
            viewModel.color
        }
    }
}

#Preview {
    TabViewExample()
}
