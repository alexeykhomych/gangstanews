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
        
        students = shoppingList
        
        self.newsView?.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "AKINewsViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.students?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.newsView!.tableView!.dequeueReusableCellWithIdentifier("AKINewsViewCell")! as UITableViewCell
        
        cell.textLabel?.text = self.students![indexPath.row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.pushViewController(AKIDetailNewsViewController())
    }

}
