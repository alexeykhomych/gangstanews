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
    
    let kAKISettings = "Settings"
    let kAKILogout = "Logout"
    let cellReuseIdentifier = "AKINewsViewCell"
    
    private var categories: Variable<AKICategoryModel>?
    
    var sortedArrayModel: AKIArrayModel?
    
    var newsView: AKINewsView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLeftBarButtonItem()
        self.initRightBarButtonItem()

        self.newsView?.tableView?.register(UINib(nibName: self.cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
        self.loadContext()
        self.loadCategory()
        
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
        return self.sortedArrayModel != nil ? (self.sortedArrayModel!.count) : (self.user?.newsArray!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCategory = self.user?.categories?.enabledCategories()
        let cell:AKINewsViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as! AKINewsViewCell
        if selectedCategory == nil {
            
            
            let content = self.user?.newsArray?.objectAtIndexSubscript(indexPath.row)
            cell.fillModel(content: content! as! AKIContent)
            
            return cell
        } else {
            
            
            let content = self.user?.newsArray?.objectAtIndexSubscript(indexPath.row) as! AKIContent
            if content.category?.name == selectedCategory?.name {
                cell.fillModel(content: content)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AKIDetailNewsViewController()
        controller.user = self.user
        controller.model = self.user?.newsArray?.objectAtIndexSubscript(indexPath.row) as AnyObject?
        self.pushViewController(controller)
    }
    
    private func tableView(_ tableView: UITableView, didEndDisplaying cell: AKINewsViewCell, forRowAt indexPath: IndexPath) {
        cell.fillModel(content: AKIContent())
    }

    private func loadContext() {
        let user = self.user
        
        let context = AKINewsContext()
        context.model = user
        let observer = context.observer()
        
        observer.subscribe(onNext: { next in
            print(next)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            self.modelDidLoad()
            
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    }
    
    private func loadCategory() {
//        let observer = self.user?.categories?.observer()
//        
//        observer?.subscribe(onNext: { next in
//            print(next)
//        }, onError: { error in
//            print(error)
//        }, onCompleted: {
//            self.modelDidLoad()
//            
//        }, onDisposed: {
//            
//        }).addDisposableTo(self.disposeBag)
    }
    
    internal override func modelDidLoad() {
        self.filterNewsModel()
        self.newsView?.tableView?.reloadData()
    }
    
    private func filterNewsModel() {
        let sort = AKISortedArrayModel()
        let selectedCategory = AKICategoryModel()
        self.sortedArrayModel?.addObjects(sort.sortArrayModel(arrayModel: (self.user?.newsArray)!, parameters: (selectedCategory.enabledCategories()?.name!)!))
        print("done")
    }
    
    private func initLeftBarButtonItem() {
                let settingsButton = UIBarButtonItem.init(title: kAKISettings,
                                                          style: UIBarButtonItemStyle.plain,
                                                          target: self,
                                                          action: #selector(settings))
        
        self.navigationItem.setLeftBarButton(settingsButton, animated: true)
    }
    
    private func initRightBarButtonItem() {
        let logoutButton = UIBarButtonItem.init(title: kAKILogout,
                                                  style: UIBarButtonItemStyle.plain,
                                                  target: self,
                                                  action: #selector(logout))
        
        self.navigationItem.setRightBarButton(logoutButton, animated: true)
    }
    
    func settings() {
        let controller = AKICategoriesViewController()
        controller.model = self.user
        controller.user = self.user
        self.pushViewController(controller)
    }
    
    func logout() {
        
    }
    
}
