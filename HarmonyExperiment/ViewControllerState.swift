//
//  ViewControllerState.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/20/24.
//

import Foundation
import Combine

final class ViewControllerState: ObservableObject {
    @Published var title: String = "Harmony Experiment"
    @Published var prefersLargeTitles: Bool = true
}
