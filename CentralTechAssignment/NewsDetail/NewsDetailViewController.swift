//
//  NewsDetailViewController.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 11/1/2564 BE.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newDetailLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    public var article : NewsList.Articles!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupNewsImageView()
        self.setupNewsTitleLabel()
        self.setupNewDetailLabel()
        self.setupUpdatedDateLabel()
    }
    
    func setupView() {
        self.title = "Detail"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupNewsImageView() {
        self.newsImageView.contentMode = .scaleAspectFill
        
        if let url = article.urlToImage {
            self.newsImageView.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.3)), .forceTransition])
        } else {
            self.newsImageView.image = UIImage(named: "no-image")
        }
    }
    
    func setupNewsTitleLabel() {
        self.newsTitleLabel.text = self.article.title ?? "-"
        self.newsTitleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .medium)
        self.newsTitleLabel.textColor = #colorLiteral(red: 0.003665005788, green: 0.6451002955, blue: 0.6055722833, alpha: 1)
    }
    
    func setupNewDetailLabel() {
        self.newDetailLabel.text = article.content ?? "-"
        self.newDetailLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        self.newDetailLabel.textColor = .black
    }
    
    func setupUpdatedDateLabel() {
        self.updatedDateLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        self.updatedDateLabel.textColor = #colorLiteral(red: 0.4418776631, green: 0.5643532276, blue: 0.6178733706, alpha: 1)
        
        if let updatedDate = article.publishedAt?.formattedDate(format: .FullDateTimeZone, locale: .En)?
            .formattedDateString(format: DateFormat.UpdatedNewsDate, locale: .En) {
            self.updatedDateLabel.text = "Updated: \(updatedDate)"
        } else {
            self.updatedDateLabel.text = "Updated: -"
        }
    }
}
