//
//  ViewRouter.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/15/21.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
}

enum Page {
    case home
    case transactions
    case reports
    case settings
}
