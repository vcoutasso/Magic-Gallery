//
//  ReusableView.swift
//  Magic-Gallery
//
//  Created by Vinícius Couto on 28/09/21.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
