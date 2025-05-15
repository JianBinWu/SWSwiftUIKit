//
//  ExampleView.swift
//  SWSwiftUIKit_Example
//
//  Created by 吴剑斌 on 2025/5/13.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct ExampleView: View {
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path){
            List(AppRoute.allCases) { route in
                Text(route.rawValue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(Color.white)
                    .onTapGesture {
                        router.push(route)
                    }
            }
            .setupAppRoutes()
        }
        .environmentObject(router)
    }
}

#Preview {
    ExampleView()
}
