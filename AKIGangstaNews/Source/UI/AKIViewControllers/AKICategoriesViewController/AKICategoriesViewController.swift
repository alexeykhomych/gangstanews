//
//  AKICategoriesViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AKICategoriesViewController: AKIAbstractViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: AKIUser?
    var context: AKINewsContext?
    let disposeBag = DisposeBag()

    let cellReuseIdentifier = "AKICategoriesViewCell"
    
    var categoriesView: AKICategoriesView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoriesView?.tableView?.register(UINib(nibName: self.cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
        self.loadContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.user?.categories?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AKICategoriesViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as! AKICategoriesViewCell
        
        if self.user?.categories?.count != nil {
            let category = self.user?.categories?.objectAtIndexSubscript(indexPath.row)
            cell.fillCategory(category: (category as? AKICategory)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = self.user?.categories?.objectAtIndexSubscript(indexPath.row)
        let cell:AKICategoriesViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as! AKICategoriesViewCell
        cell.editCategory(category: (category as? AKICategory)!)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    private func loadContext() {
        let context = AKICategoriesContext()
        context.model = self.model
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

    private func modelDidLoad() {
        self.categoriesView?.tableView?.reloadData()
    }
    
}
