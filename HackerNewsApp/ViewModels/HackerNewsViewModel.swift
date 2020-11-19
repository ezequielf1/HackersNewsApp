//
//  HackerNewsViewModel.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

protocol HackerNewsDelegate: class {
    func didTapHackerNew(hackerNew: HackerNew)
}

final class HackerNewsViewModel {
    // MARK: - Public Properties
    let hackerNews: Dynamic<[HackerNew]> = Dynamic([])
    let error: Dynamic<NetworkError?> = Dynamic(nil)
    weak var delegate: HackerNewsDelegate?
    
    // MARK: - Private Properties
    private let service: HackerNewsService
    private var deletedHackerNew: [HackerNew] = []
    
    init(service: HackerNewsService) {
        self.service = service
    }
}

// MARK: - Public Methods
extension HackerNewsViewModel {
    func fetchHackerNews() {
        service.fetchHackerNews { [weak self] result in
            guard let self = self else { return }
            self.hackerNews.value = self.getHackerNewsWithoutDeletedOnes(hackerNews: result)
        }
    }
    
    func hackerNewWasDeleted(_ hackerNew: HackerNew) {
        deletedHackerNew.append(hackerNew)
    }
    
    func didTapHackerNew(hackerNew: HackerNew) {
        delegate?.didTapHackerNew(hackerNew: hackerNew)
    }
}

// MARK: - Private Methods
private extension HackerNewsViewModel {
    func getHackerNewsWithoutDeletedOnes(hackerNews: [HackerNew]) -> [HackerNew] {
        let result = hackerNews.filter { hackerNew in
            !self.deletedHackerNew.contains(where: { $0 == hackerNew })
        }
        return result
    }
}
