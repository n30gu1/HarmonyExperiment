//
//  CollectionViewController.swift
//  HarmonyExperiment
//
//  Created by Park Seongheon on 5/18/24.
//

import UIKit
import SwiftUI

class CollectionViewController: UIViewController {
    // Diffable data source
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // Collection View
    private var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    
    struct Item: Hashable {
        let id: UUID = UUID()
        let title: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        applySnapshot()
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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
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
        snapshot.appendItems((0...10).map { _ in Item(title: "Hello, World!") })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension CollectionViewController {
    struct Representable: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> CollectionViewController {
            CollectionViewController()
        }
        
        func updateUIViewController(_ uiViewController: CollectionViewController, context: Context) {
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    CollectionViewController()
}
#endif
