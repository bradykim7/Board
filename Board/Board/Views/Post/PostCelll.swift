import UIKit
import SnapKit

class PostCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let viewsLabel = UILabel()
    private let noticeLabel = PaddedLabel()
    private let attachmentIcon = UIImageView(image: UIImage(systemName: "paperclip"))
    private let viewsIcon = UIImageView(image: UIImage(named: "Union"))

    private let customHeight: CGFloat = 74 // 원하는 높이로 설정

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.heightAnchor.constraint(equalToConstant: customHeight).isActive = true
        setViews()
    }
    
    private func setViews() {
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
        
        // Attachment Icon
        attachmentIcon.tintColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        contentView.addSubview(attachmentIcon)
        // Views Icon
        viewsIcon.tintColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        contentView.addSubview(viewsIcon)
    }
    
    private func setConstraints(isLeadingNoticeLabel: Bool) {
        if (isLeadingNoticeLabel) {
            noticeLabel.snp.makeConstraints { make in
                make.leading.equalTo(contentView).offset(15)
                make.top.equalTo(contentView).offset(10)
            }
            titleLabel.snp.makeConstraints { make in
                make.leading.equalTo(noticeLabel.snp.trailing).offset(5)
                make.centerY.equalTo(noticeLabel)
            }
        } else {
            titleLabel.snp.makeConstraints { make in
                make.leading.equalTo(contentView).offset(15)
                make.top.equalTo(contentView).offset(10)
            }
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(noticeLabel.snp.trailing).offset(5)
            make.centerY.equalTo(noticeLabel)
        }
        
        attachmentIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(titleLabel.snp.trailing).offset(3)
            make.centerY.equalTo(titleLabel)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(authorLabel.snp.trailing).offset(10)
            make.centerY.equalTo(authorLabel)
        }
        
        viewsIcon.snp.makeConstraints { make in
            make.width.equalTo(14.5)
            make.height.equalTo(9.5)
            make.leading.equalTo(dateLabel.snp.trailing).offset(5)
            make.centerY.equalTo(dateLabel)
        }
        
        viewsLabel.snp.makeConstraints { make in
            make.leading.equalTo(viewsIcon.snp.trailing).offset(5)
            make.centerY.equalTo(viewsIcon)
        }
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(authorLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        titleLabel.text = post.title
        authorLabel.text = post.writer.name
        dateLabel.text = post.createdAt
        viewsLabel.text = "\(post.viewCount)"
        noticeLabel.text = post.postType == "notice" ? "공지" : ""
        noticeLabel.isHidden = !(post.postType == "notice")
        attachmentIcon.isHidden = post.attachmentsCount == 0
        
        if post.postType == "notice" {
            setConstraints(isLeadingNoticeLabel: true)
        } else {
            setConstraints(isLeadingNoticeLabel: false)
        }
    }
}
