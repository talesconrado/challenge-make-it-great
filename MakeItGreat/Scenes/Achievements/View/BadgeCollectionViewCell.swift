//
//  BadgeCollectionViewCell.swift
//  MakeItGreat
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell, ViewCode {
    let badgeImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        image.image = UIImage(named: "AppIcon")
        image.contentMode = .scaleAspectFill
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let tasksDoneLabel: UILabel = {
        let label = UILabel()
            label.text = "-0 tasks done"
            label.font = .systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setViewHierarchy() {
        addSubview(badgeImageView)
        addSubview(tasksDoneLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            badgeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            badgeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            badgeImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            badgeImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            tasksDoneLabel.centerXAnchor.constraint(equalTo: badgeImageView.centerXAnchor),
            tasksDoneLabel.topAnchor.constraint(equalTo: badgeImageView.bottomAnchor, constant: 5)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
