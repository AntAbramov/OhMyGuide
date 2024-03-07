//
//  MainTableViewCell.swift
//  OhMyGuide
//
//  Created by Anton Abramov on 06.03.2024.
//

import UIKit

private enum Constant {
    static let collectionItemSize: CGSize = .init(width: 80, height: 80)
}

final class MainTableViewCell: UITableViewCell {
    static let reuseIdentifire = String(describing: MainTableViewCell.self)
    
    private var dataSource = [Int]()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
        
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.setContentOffset(.zero, animated: false)
    }
    
    // MARK: Interface
    func configure(witn dataSource: [Int]) {
        self.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func updateItem(with newDataSource: [Int]) {
        var mismatch = [(index: Int, value: Int)]()
        mismatch = zip(dataSource, newDataSource)
            .enumerated()
            .filter {
                $0.element.0 != $0.element.1
            }.map {
                ($0.offset, $0.element.1)
            }
        
        mismatch.forEach { tuple in
            let indexPath = IndexPath(item: tuple.index, section: 0)
            if let cell = self.collectionView.cellForItem(
                at: indexPath
            ) as? RoundedCollectionViewCell {
                cell.configure(with: tuple.value)
            }
        }
    }
}

// MARK: - Private Methods

private extension MainTableViewCell {
    func configureCollectionView() {
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        registerCells()
        addCollectionViewConstraints()
    }
    
    func addCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func registerCells() {
        collectionView.register(
            RoundedCollectionViewCell.self,
            forCellWithReuseIdentifier: RoundedCollectionViewCell.reuseIdentifire
        )
    }
}

// MARK: - UICollectionViewDataSource

extension MainTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoundedCollectionViewCell.reuseIdentifire,
            for: indexPath
        ) as! RoundedCollectionViewCell
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Constant.collectionItemSize
    }
}

// MARK: - UICollectionViewDelegate

extension MainTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item did selected at \(indexPath)")
    }
}
