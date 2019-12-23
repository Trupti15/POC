//
//  CountryViewModel.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

protocol CallbacklDelegate: class {
    func onFetchCompleted(with result: CountryInfo)
    func onFetchFailed(with reason: String)
}

class CountryViewModel {
    weak var delegate: CallbacklDelegate?
    var updateNavigationTitle: (()->())?
    var updateRefreshControl: (()->())?
    init(delegate: CallbacklDelegate) {
        self.delegate = delegate
    }
    
    var countryTitle: String? {
        didSet {
            updateNavigationTitle?()
        }
    }
}

//MARK:- API Response
extension CountryViewModel {
    func fetchAPI() {
        APIEngine().fetchCountryInfo(url: Url.feedUrl) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateRefreshControl?()
                switch result {
                case .failure(let error):
                    self.delegate?.onFetchFailed(with: error)
                case .success(let results):
                    self.countryTitle = results.title ?? ""
                    let processedResult = self.removeDataWithNoTitle(result: results)
                    self.delegate?.onFetchCompleted(with: processedResult)
                }
            }
        }
    }
    
    func removeDataWithNoTitle(result: CountryInfo) -> CountryInfo {
        let countryTitle = result.title ?? ""
        guard let facts = result.facts else { return result }
        let filteredFacts = facts.filter({ $0.title != nil })
        return CountryInfo(title: countryTitle, facts: filteredFacts)
    }
}
