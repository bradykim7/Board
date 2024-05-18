import UIKit
import SnapKit

class PostCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let viewsLabel = UILabel()
    private let noticeLabel = PaddedLabel()
    private let replyLabel = PaddedLabel()
    private let newLabel = RoundCell()
    private let attachmentIcon = UIImageView(image: UIImage(systemName: "paperclip"))
    private let viewsIcon = UIImageView(image: UIImage(named: "Union"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Title Label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(titleLabel)
        
        // Author Label
        authorLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        authorLabel.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        contentView.addSubview(authorLabel)
        
        // Date Label
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        dateLabel.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        contentView.addSubview(dateLabel)
        
        // Views Label
        viewsLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        viewsLabel.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        contentView.addSubview(viewsLabel)
        
        // Notice Label
        noticeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        noticeLabel.backgroundColor = .systemYellow
        noticeLabel.layer.cornerRadius = 10
        noticeLabel.layer.masksToBounds = true
        noticeLabel.textColor = .white
        contentView.addSubview(noticeLabel)
        
        // Reply Label
        replyLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        replyLabel.backgroundColor = UIColor(red: 71/255, green: 57/255, blue: 43/255, alpha: 1)
        replyLabel.layer.cornerRadius = 10
        replyLabel.layer.masksToBounds = true
        replyLabel.textColor = .white
        contentView.addSubview(replyLabel)
        
        // New Label
        newLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        newLabel.backgroundColor = UIColor(red: 219/255, green: 71/255, blue: 13/255, alpha: 1)
        newLabel.layer.cornerRadius = 10
        newLabel.layer.masksToBounds = true
        newLabel.textColor = .white
        contentView.addSubview(newLabel)
        
        // Attachment Icon
        attachmentIcon.tintColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        contentView.addSubview(attachmentIcon)
        
        // Views Icon
        viewsIcon.tintColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        contentView.addSubview(viewsIcon)
    }
    
    private func setupConstraints() {
        // Notice Label Constraints
        noticeLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
        }
        
        // Reply Label Constraints
        replyLabel.snp.makeConstraints { make in
            make.leading.equalTo(noticeLabel.snp.trailing).offset(5)
            make.trailing.equalTo(contentView).offset(-15)
            make.top.equalTo(contentView).offset(10)
        }
        
        // Title Label Constraints
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(replyLabel.snp.trailing).offset(5)
            make.trailing.equalTo(contentView).offset(-15)
            make.top.equalTo(contentView).offset(10)
        }
        
        // Attachment Icon Constraints
        attachmentIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(titleLabel)
        }
        
        // New Label Constraints
        newLabel.snp.makeConstraints { make in
            make.leading.equalTo(attachmentIcon.snp.trailing).offset(5)
            make.centerY.equalTo(attachmentIcon)
        }
        
        // Author Label Constraints
        authorLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        // Date Label Constraints
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(authorLabel.snp.trailing).offset(10)
            make.centerY.equalTo(authorLabel)
        }
        
        // Views Icon Constraints
        viewsIcon.snp.makeConstraints { make in
            make.width.equalTo(14.5)
            make.height.equalTo(9.5)
            make.leading.equalTo(dateLabel.snp.trailing).offset(5)
            make.centerY.equalTo(dateLabel)
        }
        
        // Views Label Constraints
        viewsLabel.snp.makeConstraints { make in
            make.leading.equalTo(viewsIcon.snp.trailing).offset(5)
            make.centerY.equalTo(viewsIcon)
        }
        
        // Content View Bottom Constraints
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(authorLabel.snp.bottom).offset(10)
        }
    }
    
    func configure(with post: Post) {
        var title = post.title
        if let range = title.range(of: "[Re]") {
            title.removeSubrange(range)
        }
        titleLabel.text = title
        authorLabel.text = post.writer.name
        dateLabel.text = DateHelper.formatDateString(post.createdAt, from: "yyyy-MM-dd'T'HH:mm:ssZ", to: "yy-MM-dd")
        viewsLabel.text = "\(post.viewCount)"
        noticeLabel.text = post.postType == "notice" ? "공지" : ""
        noticeLabel.isHidden = !(post.postType == "notice")
        replyLabel.text = post.postType == "reply" ? "Re" : ""
        replyLabel.isHidden = !(post.postType == "reply")
        let isNew = DateHelper.isWithin24Hours(dateString: post.createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ")
        newLabel.text = isNew ? "N" : ""
        newLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        newLabel.isHidden = !isNew
        attachmentIcon.isHidden = post.attachmentsCount == 0
        
        // Update Notice Label Constraints
        if post.postType == "notice" {
            replyLabel.snp.removeConstraints()
            noticeLabel.snp.remakeConstraints { make in
                make.leading.equalTo(contentView).offset(15)
                make.top.equalTo(contentView).offset(10)
            }
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(noticeLabel.snp.trailing).offset(5)
                make.trailing.equalTo(contentView).offset(-15)
                make.centerY.equalTo(noticeLabel)
            }
        } else if post.postType == "reply" {
            noticeLabel.snp.removeConstraints()
            replyLabel.snp.remakeConstraints { make in
                make.leading.equalTo(contentView).offset(15)
                make.top.equalTo(contentView).offset(10)
            }
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(replyLabel.snp.trailing).offset(5)
                make.trailing.equalTo(contentView).offset(-15)
                make.centerY.equalTo(replyLabel)
            }
        } else {
            noticeLabel.snp.removeConstraints()
            replyLabel.snp.removeConstraints()
            titleLabel.snp.remakeConstraints { make in
                make.leading.equalTo(contentView).offset(15)
                make.trailing.equalTo(contentView).offset(-15)
                make.top.equalTo(contentView).offset(10)
            }
        }
        
        if isNew && post.attachmentsCount == 0 {
            attachmentIcon.snp.removeConstraints()
            newLabel.snp.remakeConstraints { make in
                make.leading.equalTo(titleLabel.snp.trailing).offset(5)
                make.trailing.equalTo(contentView).offset(-15)
            }
        } else {
            
        }
    }
}
