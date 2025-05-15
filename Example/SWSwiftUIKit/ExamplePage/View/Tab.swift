//
//  Tab.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/15.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct Tab: View {
    @ObservedObject var viewModel: TabViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .foregroundColor(viewModel.isSelected ? .black : .gray)
                .fontWeight(viewModel.isSelected ? .bold : .regular)

            if viewModel.isSelected {
                Capsule()
                    .fill(.red)
                    .frame(height: 3)
                    .padding(.bottom, 4)
            } else {
                Color.clear.frame(height: 3).padding(.bottom, 4)
            }
        }
    }
}
