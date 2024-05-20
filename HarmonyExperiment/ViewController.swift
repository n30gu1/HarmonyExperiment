//
//  ViewController.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/17/24.
//

import SwiftUI
import UIKit
import Combine

class ViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    var state = ViewControllerState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        setupSubscription()
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Harmony Experiment"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let hosting = UIHostingController(rootView: ContentView(state: state))
        view.addSubview(hosting.view)

        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupSubscription() {
        state.$title
            .sink { [weak self] title in
                self?.navigationItem.title = title
            }
            .store(in: &cancellables)
        
        state.$prefersLargeTitles
            .sink { [weak self] prefersLargeTitles in
                self?.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
            }
            .store(in: &cancellables)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancellables.removeAll()
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ViewController())
}
#endif
