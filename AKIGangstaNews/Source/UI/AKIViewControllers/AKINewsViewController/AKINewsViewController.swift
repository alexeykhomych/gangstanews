//
//  AKINewsViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKINewsViewController: AKIGangstaNewsViewController, UITableViewDelegate, UITableViewDataSource {
    
    let kAKICategories = "Categories"
    let kAKILogout = "Logout"
    let cellReuseIdentifier = "AKINewsViewCell"
    
    private var sortedArrayModel: AKISortedArrayModel?
    
    var newsView: AKINewsView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLeftBarButtonItem()
        self.initRightBarButtonItem()

        self.newsView?.tableView?.register(UINib(nibName: self.cellReuseIdentifier, bundle: nil),
                                           forCellReuseIdentifier: self.cellReuseIdentifier)
        self.loadContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.filterNewsModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedArrayModel != nil ? (self.sortedArrayModel!.count) : ((self.model as? AKIUser)?.newsArray!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AKINewsViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as! AKINewsViewCell
        
        let content: AKIContent?
        let sortedArrayModel = self.sortedArrayModel
        
        if sortedArrayModel != nil {
            content = sortedArrayModel?.objectAtIndexSubscript(indexPath.row) as? AKIContent
        } else {
            content = (self.model as? AKIUser)?.newsArray?.objectAtIndexSubscript(indexPath.row) as? AKIContent
        }
        
        cell.fillModel(content: content!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AKIDetailNewsViewController()
        let user = self.model as? AKIUser
        controller.model = user!
        controller.content = user?.newsArray?.objectAtIndexSubscript(indexPath.row) as? AKIContent
        self.pushViewController(controller)
    }
    
    private func tableView(_ tableView: UITableView, didEndDisplaying cell: AKINewsViewCell, forRowAt indexPath: IndexPath) {
        cell.fillModel(content: nil)
    }

    private func loadContext() {
        let user = self.model
        let context = AKINewsContext()
        context.model = user
        self.setObserver(context)
    }
    
    internal override func modelDidLoad() {
        DispatchQueue.main.async {
            AKISpinnerViewContainer.observer?.onCompleted()
            self.newsView?.spinnerViewVisible = false
            self.newsView?.tableView?.reloadData()
        }
    }
    
    private func filterNewsModel() {
        let category = (self.model as? AKIUser)?.categories?.selectedCategory
        
        if category != nil {
            let sort = AKISortedArrayModel()
            sort.addObjects(sort.sortArrayModel(arrayModel: ((self.model as? AKIUser)?.newsArray)!,
                                                parameters: (category?.name)!))
            self.sortedArrayModel = sort
            self.newsView?.tableView?.reloadData()
        }
    }
    
    private func initLeftBarButtonItem() {
        let settingsButton = UIBarButtonItem.init(title: kAKICategories,
                                                  style: UIBarButtonItemStyle.plain,
                                                  target: self,
                                                  action: #selector(selectCategory))
        
        self.navigationItem.setLeftBarButton(settingsButton, animated: true)
    }
    
    private func initRightBarButtonItem() {
        let logoutButton = UIBarButtonItem.init(title: kAKILogout,
                                                style: UIBarButtonItemStyle.plain,
                                                target: self,
                                                action: #selector(logout))
        
        self.navigationItem.setRightBarButton(logoutButton, animated: true)
    }
    
    func selectCategory() {
        let controller = AKICategoriesViewController()
        controller.model = self.model
        self.pushViewController(controller)
    }
    
    func logout() {
        self.newsView?.tableView?.reloadData()
        self.showErrorAllert()
        
//        let user = self.model as! AKIUser?
//        let context = AKILogoutContext()
//        context.model = user
//        self.setObserver(context)
//        self.saveDataToDisk(data: user?.authKey as AnyObject, key: kAKIParserAuthKey)r
    }
}
