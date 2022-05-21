//
//  EditorBackgroundView.swift
//  Behance-iOS
//
//  Created by Inwoo Park on 2022/05/21.
//

import UIKit

final class EditorBackgroundView: UIView {
    
    private let wholeStackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        self.backgroundColor = .white
        
        imageView.image = Const.Image.grid
        wholeStackView.addArrangedSubview(imageView)
        
        titleLabel.text = "프로젝트 시작"
        wholeStackView.addArrangedSubview(titleLabel)
        
        contentLabel.text = "아래 툴을 사용하여 내 프로젝트에\n콘텐츠를 추가할 수 있습니다."
        contentLabel.numberOfLines = 2
        contentLabel.textAlignment = .center
        wholeStackView.addArrangedSubview(contentLabel)
        
        self.addSubview(wholeStackView)
        wholeStackView.spacing = 20
        wholeStackView.alignment = .center
        wholeStackView.axis = .vertical
        wholeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wholeStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wholeStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
