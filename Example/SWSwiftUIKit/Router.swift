//
//  Router.swift
//  TVBrowser
//
//  Created by 吴剑斌 on 2025/5/13.
//

import Foundation
import SwiftUICore

enum AppRoute: String, CaseIterable, Identifiable {
    case carousel
    case refresh
    case tabView
    
    var id: String { rawValue }
}

class Router: ObservableObject {
    @Published var path: [AppRoute] = []

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}

extension View {
    func setupAppRoutes() -> some View {
        self.navigationDestination(for: AppRoute.self) { route in
            switch route {
            case .carousel:
                CarouselViewExample()
            case .refresh:
                RefreshViewExample()
            case .tabView:
                TabViewExample()
            }
        }
    }
}
