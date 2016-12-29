//
//  AKIDetailNewsContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire

let kAKIArchivedContentModel = "AKIArchivedContentModel"

class AKIDetailNewsContext: AKINewsContext {
    
    var id: String?
    
    override var filePath: String {
        return self.path.appending("/\(kAKIArchivedContentModel)\(self.id)")
    }
    
    override var url: String {
        return "\(kAKIAPIURL)\(kAKIDetailNewsRequest)\(self.id!)"
    }
    
    override func parseJSON(_ json: NSDictionary) {
        guard let data = json.object(forKey: kAKIParserData) as? [Any] else { return }
        guard let dictionary = data[0] as? [String: Any] else { return }

        let content = self.selectedContent(((self.model as? AKIUser)?.newsArray?.objects)!)
        content?.dataText = dictionary[kAKIParserDesc] as! String?
    }
    
    private func selectedContent(_ newsArray: NSArray) -> AKIContent? {
        for news in newsArray as! Array<AKIContent> {
            if news.id == self.id {
                return news
            }
        }
        
        return nil
    }
    
    override func load() {
        var model: Any?
        
        if self.cached {
            model = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath)
        } else {
            self.parseError()
            return
        }
        
        let content = self.selectedContent(((self.model as? AKIUser)?.newsArray?.objects)!)
        content?.dataText = model as? String
    }
    
    override func save() {
        self.removeCachedModel()
        self.fileManager.createFile(atPath: self.filePath, contents: nil, attributes: nil)
        NSKeyedArchiver.archiveRootObject(self.archivingContentModel(), toFile: self.filePath)
        }
    
    func archivingContentModel() -> String {
        return self.selectedContent(((self.model as? AKIUser)?.newsArray?.objects)!)!.dataText!
    }
}
