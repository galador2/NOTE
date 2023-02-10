//
//  CustomTableViewCell.swift
//  Note
//
//  Created by Kirill  Kostenko  on 09.02.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let image: UIImage?
        //let text: String
       // let indexPath: IndexPath
        
    }

    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    private lazy var titleLabel: UILabel = {
//        let titleLabel = UILabel()
//
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        return titleLabel
//    }()
    
//    private lazy var button: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 6
//        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
    //    self.titleLabel.text = nil
    //    self.indexPath = nil
    }
    
    func setup(with viewModel: ViewModel) {
        self.myImageView.image = viewModel.image
      //  self.titleLabel.text = viewModel.text
        //self.indexPath = viewModel.indexPath
    }
    
    func changeText(_ text: String) {
   //     self.titleLabel.text = text
    }
    
    private func setupView() {
        self.contentView.addSubview(self.myImageView)
      //  self.contentView.addSubview(self.titleLabel)
        //self.contentView.addSubview(self.button)
        
        NSLayoutConstraint.activate([
            self.myImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.myImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.myImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.myImageView.widthAnchor.constraint(equalTo: self.myImageView.heightAnchor, multiplier: 1.0),

//            self.titleLabel.centerYAnchor.constraint(equalTo: self.myImageView.centerYAnchor),
//            self.titleLabel.leftAnchor.constraint(equalTo: self.myImageView.rightAnchor, constant: 16),

//            self.button.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
//            self.button.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
//            self.button.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 16),
//            self.button.heightAnchor.constraint(equalToConstant: 34),
//            self.button.widthAnchor.constraint(equalTo: self.button.heightAnchor, multiplier: 1.0)
        ])
    }
    
//    @objc private func didTapButton() {
//        guard let indexPath = indexPath else { return }
//
//        print("Section: \(indexPath.section), Row: \(indexPath.row)")
//    }
}
