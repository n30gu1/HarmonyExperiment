//
//  CollectionViewController.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/18/24.
//

import Combine
import SwiftUI
import UIKit

class CollectionViewController: UIViewController {
    // State
    weak var state: ViewControllerState?
    var cancellables = Set<AnyCancellable>()
    
    // Diffable data source
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // Collection View
    private var collectionView: UICollectionView!
    
    init(state: ViewControllerState) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        applySnapshot()
        subscribe()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .insetGrouped))
        return layout
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, _, item in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            return cell
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems((0 ... 10).map { _ in Item(title: "Hello, World!") })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func subscribe() {
        state?.$sections
            .sink { [weak self] sections in
                if var snapshot = self?.dataSource.snapshot() {
                    snapshot.deleteSections(snapshot.sectionIdentifiers)
                    snapshot.appendSections(sections)
                    self?.dataSource.apply(snapshot, animatingDifferences: true)
                }
            }
            .store(in: &cancellables)
        
        state?.$items
            .sink { [weak self] items in
                if var snapshot = self?.dataSource.snapshot() {
                    snapshot.deleteItems(snapshot.itemIdentifiers)
                    snapshot.appendItems(items)
                    self?.dataSource.apply(snapshot, animatingDifferences: true)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension CollectionViewController {
    struct Representable: UIViewControllerRepresentable {
        @ObservedObject var state: ViewControllerState
        
        func makeUIViewController(context: Context) -> some UIViewController {
            CollectionViewController(state: state)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    @ObservedObject var state = ViewControllerState()
    return CollectionViewController(state: state)
}
#endif
