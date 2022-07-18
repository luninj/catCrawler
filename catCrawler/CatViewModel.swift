//
//  CatViewModel.swift
//  catCrawler
//
//  Created by JunyeongChoi on 2022/07/19.
//

import Foundation

protocol CatViewModelOutput: AnyObject {
    func loadComplete()
}

final class CatViewModel {
    
    private var currentPage = 0
    
    private var limit = 3 * 7
    
    private let service = CatService()
    
    var data : [CatResponse] = []
    
    weak var delegate : CatViewModelOutput?
    
    func load() {
        self.service.getCats(page: self.currentPage, limit: self.limit) {
            result in
            
            switch result {
            case .failure(let error):
                break
            case . success(let response):
                self.data.append(contentsOf: response)
                self.delegate?.loadComplete()
            }
        }
    }
}
