//
//  AKINewsViewController.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 22.11.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

class AKINewsViewController: AKIAbstractViewController {
    
    var students: NSArray?
    
    var newsView: AKINewsView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let shoppingList: [String] = ["Eggs", "Milk"]
        
        students = shoppingList as NSArray?
        
        self.newsView?.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "AKINewsViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.students?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.newsView!.tableView!.dequeueReusableCell(withIdentifier: "AKINewsViewCell")! as UITableViewCell
        
        cell.textLabel?.text = self.students![indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.pushViewController(AKIDetailNewsViewController())
    }

}
