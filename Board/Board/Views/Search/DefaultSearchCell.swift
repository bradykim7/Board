//
//  DefaultSearchCell.swift
//  Board
//
//  Created by Minseok Brady Kim on 5/19/24.
//

import Foundation
import UIKit
import SnapKit

class DefaultSearchCell: UITableViewCell {
    
    let cellImageView = UIImageView()
    let cellLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellLabel)
        
        cellImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            
            make.width.equalTo(110.92)
            make.height.equalTo(172)  // 이미지 크기 설정
        }
        
        cellLabel.font = .systemFont(ofSize: 14)
        cellLabel.textColor = .gray
        cellLabel.textAlignment = .center
        cellLabel.numberOfLines = 0
        
        cellLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(238)
            make.top.equalTo(cellImageView.snp.bottom).offset(20)
        }
    }
    
    func configure() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        cellImageView.image = UIImage(named: "Illust")
        cellLabel.text = "게시글의 제목, 내용 또는 작성자에 포함된 단어 또는 문장을 검색해 주세요."
    }
}
