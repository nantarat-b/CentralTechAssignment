//
//  NewsListViewController.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 8/1/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var loadMoreLoading: UIActivityIndicatorView!
    @IBOutlet weak var newsListTableView: UITableView!
    
    private var searchBar = UISearchBar()
    private var refreshControl = UIRefreshControl()
    
    private var newsListViewModel = NewsListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRefreshControl()
        self.setupSearchBar()
        self.setupTableView()
        self.setupLoading()
        self.setupLoadMoreLoading()
        
        self.newsListViewModel.getNews()
    }
    
    private func setupRefreshControl() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.newsListTableView.addSubview(self.refreshControl)
        self.refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.newsListViewModel.getNews(searchText: self?.searchBar.text, isRefresh: true)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        self.newsListViewModel.refreshLoading.bind(to: self.refreshControl.rx.isRefreshing).disposed(by: disposeBag)
    }
    
    private func setupSearchBar() {
        self.hideKeyboardWhenTappedAround()
        self.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        self.searchBar.showsCancelButton = true
        self.searchBar.searchBarStyle = UISearchBar.Style.minimal
        self.searchBar.placeholder = ""
        self.searchBar.sizeToFit()
        self.searchBar.showsCancelButton = false
        self.searchBar.backgroundColor = #colorLiteral(red: 0.7833494544, green: 0.7884549499, blue: 0.8054184318, alpha: 1)
        self.searchBar.compatibleSearchTextField.alpha = 1
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        self.newsListTableView.backgroundColor = .white
        self.newsListTableView.tableHeaderView = self.searchBar
        
        self.searchBar
            .rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(700), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.newsListViewModel.getNews(searchText: query, isLoadMore: false)
            }).disposed(by: disposeBag)
    }
    
    private func setupLoading() {
        self.newsListViewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
    }
    
    private func setupLoadMoreLoading() {
        self.newsListViewModel.loadMoreLoading.bind(to: self.loadMoreLoading.rx.isAnimating).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        self.newsListTableView.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: NewsListTableViewCell.self))
        
        self.newsListViewModel.articles.bind(to: newsListTableView.rx.items(cellIdentifier: "NewsListTableViewCell", cellType: NewsListTableViewCell.self)) {  (row, article, cell) in
            cell.article = article
        }.disposed(by: disposeBag)
        
        self.newsListTableView.rx.willDisplayCell
            .subscribe(onNext: ({ [unowned self] (cell,indexPath) in
                if (self.newsListViewModel.articles.value.count - 1)  == indexPath.row {
                    self.newsListViewModel.getNews(searchText: self.searchBar.text, isLoadMore: true)
                }
            })).disposed(by: disposeBag)
        
        self.newsListTableView.rx.modelSelected(NewsList.Articles.self).subscribe(onNext: { [unowned self] article in
            let storyboard = UIStoryboard(name: "NewsDetail", bundle: nil)
            let newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "NewsDetail") as! NewsDetailViewController
            newsDetailViewController.article = article
            self.navigationController?.pushViewController(newsDetailViewController, animated: true)
        }).disposed(by: disposeBag)
    }

}
