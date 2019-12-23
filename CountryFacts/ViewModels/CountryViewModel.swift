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

    func fetchAPI() {
        APIEngine().fetchCountryInfo(url: Url.feedUrl) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.updateRefreshControl?()
                switch result {
                case .failure(let error):
                    self?.delegate?.onFetchFailed(with: error)
                case .success(let results):
                    self?.delegate?.onFetchCompleted(with: results)
                }
            }
        }
    }
}
