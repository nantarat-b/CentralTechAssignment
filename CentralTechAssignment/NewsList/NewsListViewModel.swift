//
//  NewsListViewModel.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 8/1/2564 BE.
//

import Foundation
import RxSwift
import RxCocoa



class NewsListViewModel {
    
    public var articles : BehaviorRelay<[NewsList.Articles]> = BehaviorRelay(value: [])
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let loadMoreLoading: PublishSubject<Bool> = PublishSubject()
    public let refreshLoading: PublishSubject<Bool> = PublishSubject()
    
    private let disposable = DisposeBag()
    private var isFetching = false
    private var isMaxTotalResults = false
    private var searchText: String? = nil
    private var page: Int = 1
    
    public func getNews(searchText: String? = nil, isLoadMore: Bool = false, isRefresh: Bool = false) {
        if searchText != self.searchText {
            self.page = 1
            self.isMaxTotalResults = false
            self.searchText = searchText
        }
        
        if isRefresh {
            self.page = 1
            self.isMaxTotalResults = false
        }
        
        if !self.isFetching && !self.isMaxTotalResults {
            self.isFetching = true
            let api = APIManager()
            
            self.page = isLoadMore ? self.page + 1 : 1
            
            var url = "http://newsapi.org/v2/top-headlines?country=us&category=business&page=\(self.page)&apiKey=c595b516d4d04f3593b45a4025a2e609"
            
            if let search = searchText, !search.isEmpty {
                url += "&q=\(search)"
            }
            
            self.loading.onNext(!isLoadMore)
            self.loadMoreLoading.onNext(isLoadMore)
            api.callRequest(url: url, method: .get, type: NewsList.self) { (newsList) in
                self.loading.onNext(false)
                self.loadMoreLoading.onNext(false)
                self.isFetching = false
                if isRefresh {
                    self.refreshLoading.onNext(false)
                }
                if let articles = newsList?.articles,
                   let total = newsList?.totalResults {
                    
                    var data = articles
                    if self.page != 1 {
                        data = self.articles.value + articles
                    }
            
                    self.isMaxTotalResults = (data.count >= total)
                    self.articles.accept(data)
                }
            } failure: {
                self.page = isLoadMore ? self.page - 1 : 1
                self.loading.onNext(false)
                self.loadMoreLoading.onNext(false)
                self.isFetching = false
                if isRefresh {
                    self.refreshLoading.onNext(false)
                }
            }
        }
    }
}
