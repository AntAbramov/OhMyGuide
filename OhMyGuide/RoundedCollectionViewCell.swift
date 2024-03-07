//
//  RoundedCollectionViewCell.swift
//  OhMyGuide
//
//  Created by Anton Abramov on 07.03.2024.
//

import UIKit

final class RoundedCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifire = String(describing: RoundedCollectionViewCell.self)
    
    private let label = UILabel()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: isHighlighted
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }
    
    // MARK: Interface
    func configure(with int: Int) {
        label.text = "\(int)"
    }
}

// MARK: - Private Methods

private extension RoundedCollectionViewCell {
    func setupView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = UIColor.blue
        setupLabel()
    }
    
    func setupLabel() {
        addSubview(label)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
