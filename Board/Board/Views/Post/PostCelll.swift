import UIKit

class PostCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let dateLabel = UILabel()
    let viewsLabel = UILabel()
    let noticeLabel = PaddedLabel()
    let attachmentIcon = UIImageView(image: UIImage(systemName: "paperclip"))
    
    // 제약 조건을 저장하는 프로퍼티
    var titleLeadingWithNotice: NSLayoutConstraint!
    var titleLeadingToContent: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Title Label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(titleLabel)
        
        // Author Label
        authorLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        authorLabel.textColor = .gray
        contentView.addSubview(authorLabel)
        
        // Date Label
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        dateLabel.textColor = .gray
        contentView.addSubview(dateLabel)
        
        // Views Label
        viewsLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        viewsLabel.textColor = .gray
        contentView.addSubview(viewsLabel)
        
        // Notice Label
        noticeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        noticeLabel.backgroundColor = .systemYellow
        noticeLabel.layer.cornerRadius = 10
        noticeLabel.layer.masksToBounds = true
        noticeLabel.textColor = .white
        contentView.addSubview(noticeLabel)
        
        // Attachment Icon
        contentView.addSubview(attachmentIcon)
        
        // Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        attachmentIcon.translatesAutoresizingMaskIntoConstraints = false
        
        titleLeadingWithNotice = titleLabel.leadingAnchor.constraint(equalTo: noticeLabel.trailingAnchor, constant: 5)
        titleLeadingToContent = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)

        NSLayoutConstraint.activate([
            noticeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            noticeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLeadingToContent,
            
            attachmentIcon.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            attachmentIcon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 10),
            dateLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            
            viewsLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
            viewsLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        titleLabel.text = post.title
        authorLabel.text = post.writer.name
        dateLabel.text = post.createdAt
        viewsLabel.text = "조회수 \(post.viewCount)"
        noticeLabel.text = post.isNotify ? "공지" : ""
        noticeLabel.isHidden = !post.isNotify
        attachmentIcon.isHidden = post.attachmentsCount == 0
        
        if post.isNotify {
            titleLeadingToContent.isActive = false
            titleLeadingWithNotice.isActive = true
        } else {
            titleLeadingWithNotice.isActive = false
            titleLeadingToContent.isActive = true
        }
    }
}
