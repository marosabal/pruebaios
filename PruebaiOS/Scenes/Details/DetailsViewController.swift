//
//  DetailsViewController.swift
//  PruebaiOS
//
//  Created by Ale on 8/1/19.
//  Copyright (c) 2019 everis. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func displayMovie(viewModel: Details.Movie.ViewModel)
}

class DetailsViewController: UIViewController, DetailsDisplayLogic {
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Outlets
    
    // MARK: - Attributes
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
    }
    
    // MARK: - Private
    
    // MARK: - DetailsDisplayLogic

    func displayMovie(viewModel: Details.Movie.ViewModel) {
        title = viewModel.title
    }
}
