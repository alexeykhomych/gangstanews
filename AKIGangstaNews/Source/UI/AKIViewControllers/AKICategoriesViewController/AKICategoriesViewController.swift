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

class AKICategoriesViewController: AKIGangstaNewsViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categoriesView: AKICategoriesView? {
        return self.getView()
    }
    
    //MARK: Initializations and Deallocations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let classNewsViewCell = AKICategoriesViewCell.self
        self.categoriesView?.tableView?.register(UINib.nibWithClass(classNewsViewCell),
                                           forCellReuseIdentifier: String(describing: classNewsViewCell.self))
        self.loadContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: View Lifecycle
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.model as! AKIUser?)?.categories?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cls = String(describing: AKICategoriesViewCell.self)
        let cell:AKICategoriesViewCell = tableView.dequeueReusableCell(withIdentifier: cls) as! AKICategoriesViewCell
        
        let user = self.model as? AKIUser
        
        if user?.categories?.count != nil {
            let category = user?.categories?.objectAtIndexSubscript(indexPath.row)
            cell.fillCategory(category: (category as? AKICategory)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categories = (self.model as! AKIUser?)?.categories
        categories?.selectedCategory = categories?.objectAtIndexSubscript(indexPath.row) as! AKICategory?
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private
    
    private func loadContext() {
        let context = AKICategoriesContext()
        context.model = self.model
        self.setObserver(context)
    }

    internal override func modelDidLoad() {
        DispatchQueue.main.async {
            self.categoriesView?.spinnerView?.visible = false
            self.categoriesView?.tableView?.reloadData()
        }
    }
    
}
