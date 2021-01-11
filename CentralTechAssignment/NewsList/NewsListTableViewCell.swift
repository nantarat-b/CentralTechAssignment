//
//  NewsListTableViewCell.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 8/1/2564 BE.
//

import UIKit
import Kingfisher

class NewsListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newDetailLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    public var article : NewsList.Articles! {
        didSet {
            self.newsTitleLabel.text = article.title
            self.newDetailLabel.text = article.description ?? "-"
            
            if let url = article.urlToImage {
                self.newsImageView.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.3)), .forceTransition])
            } else {
                self.newsImageView.image = UIImage(named: "no-image")
            }
            
            if let updatedDate = article.publishedAt?.formattedDate(format: .FullDateTimeZone, locale: .En)?
                .formattedDateString(format: DateFormat.UpdatedNewsDate, locale: .En) {
                self.updatedDateLabel.text = "Updated: \(updatedDate)"
            } else {
                self.updatedDateLabel.text = "Updated: -"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupView()
        self.setupNewsImageView()
        self.setupNewsTitleLabel()
        self.setupNewDetailLabel()
        self.setupUpdatedDateLabel()
    }
    
    private func setupView() {
        self.selectionStyle = .none
    }
    
    private func setupNewsImageView() {
        self.newsImageView.contentMode = .scaleAspectFit
    }
    
    private func setupNewsTitleLabel() {
        self.newsTitleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .medium)
        self.newsTitleLabel.textColor = #colorLiteral(red: 0.003665005788, green: 0.6451002955, blue: 0.6055722833, alpha: 1)
    }
    
    private func setupNewDetailLabel() {
        self.newDetailLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        self.newDetailLabel.textColor = .black
    }
    
    private func setupUpdatedDateLabel() {
        self.updatedDateLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        self.updatedDateLabel.textColor = #colorLiteral(red: 0.4418776631, green: 0.5643532276, blue: 0.6178733706, alpha: 1)
    }
    
    override func prepareForReuse() {
        self.newsImageView.image = UIImage()
    }

}
