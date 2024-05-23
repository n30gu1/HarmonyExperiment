//
//  ViewController.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/17/24.
//

import Combine
import SwiftUI
import UIKit

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
        navigationItem.title = "Harmony Experiment"
        navigationController?.navigationBar.prefersLargeTitles = true

        let hosting = UIHostingController(rootView: ContentView(state: state))
        
        view.addSubviewWithFullScreen(hosting.view)
    }
    
    func setupSubscription() {
        state.$title
            .sink { [weak self] title in
                print(title)
                self?.navigationItem.title = title
            }
            .store(in: &cancellables)
        
        state.$prefersLargeTitles
            .sink { [weak self] prefersLargeTitles in
                print(prefersLargeTitles)
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
