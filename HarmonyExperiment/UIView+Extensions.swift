//
//  UIView+Extensions.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/23/24.
//

import Foundation
import SwiftUI
import UIKit

extension UIView {
    func addSubviewWithFullScreen(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
