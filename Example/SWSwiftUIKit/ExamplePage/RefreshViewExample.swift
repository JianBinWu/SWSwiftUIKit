//
//  RefreshViewExample.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/14.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct RefreshViewExample: View {
    @ObservedObject var viewModel = RefreshExampleViewModel()
    
    var body: some View {
        SWRefreshableScrollView(viewModel: viewModel.refreshViewModel) {
            VStack(alignment: .leading) {
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach(viewModel.list) {
                        $0.color
                            .aspectRatio(3 / 4.0, contentMode: .fill)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    RefreshViewExample()
}
