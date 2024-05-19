//
//  SearchCell.swift
//  Board
//
//  Created by Minseok Brady Kim on 5/19/24.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    let fixedLabel = UILabel()
    let queryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(fixedLabel)
        contentView.addSubview(queryLabel)
        
        fixedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        queryLabel.snp.makeConstraints { make in
            make.leading.equalTo(fixedLabel.snp.trailing).offset(0)
            make.centerY.equalToSuperview()
        }
        
        fixedLabel.font = .systemFont(ofSize: 14, weight: .bold)
        fixedLabel.textColor = .gray
        
        queryLabel.font = .systemFont(ofSize: 14)
        queryLabel.textColor = .black
    }
    
    func configure(fixedText: String, queryText: String) {
        fixedLabel.text = fixedText
        queryLabel.text = queryText
    }
}
