//
//  ViewControllerState.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/20/24.
//

import Combine
import Foundation

final class ViewControllerState: ObservableObject {
    @Published var title: String = "Harmony Experiment"
    @Published var prefersLargeTitles: Bool = true
    @Published var sections: [Section] = [.main]
    @Published var items: [Item] = []
}

enum Section {
    case main
}

struct Item: Hashable {
    let id: UUID = .init()
    let title: String
}
