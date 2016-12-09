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

class AKINewsViewController: AKIAbstractViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: AKIUser?
    
    var context: AKINewsContext?
    
    var students: NSArray?
    let disposeBag = DisposeBag()
    
    let cellReuseIdentifier = "AKINewsViewCell"
    
    var newsView: AKINewsView? {
        return self.getView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        self.fillArray()
        self.newsView?.tableView?.register(UINib(nibName: "AKINewsViewCell", bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
        self.loadContext()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.user?.newsArray.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AKINewsViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as! AKINewsViewCell
        let content = self.user?.newsArray[indexPath.row]
        cell.fillModel(content: content! as! AKIContent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AKIDetailNewsViewController()
        controller.user = self.user
        controller.model = self.user?.newsArray[indexPath.row] as AnyObject?
        self.pushViewController(controller)
    }
    
    private func tableView(_ tableView: UITableView, didEndDisplaying cell: AKINewsViewCell, forRowAt indexPath: IndexPath) {
        cell.fillModel(content: AKIContent())
    }

    private func loadContext() {
        let context = AKINewsContext()
        self.context = context
        
        context.model = self.user
        context.newsRequest()
    }
    
    private func fillArray() {
        var array = NSMutableArray()
        let news = AKIContent()
        news.header = "One by One, ISIS Social Media Experts Are Killed as Result of F.B.I. Program"
//        news.dataText = "<p>WASHINGTON — In the summer of 2015, armed American drones over eastern Syria stalked Junaid Hussain, an influential hacker and recruiter for the Islamic State.</p>\n                 <p>For weeks, Mr. Hussain was careful to keep his young stepson by his side, and the drones held their fire. But late one night, Mr. Hussain left an internet cafe alone, and minutes later a Hellfire missile killed him as he walked between two buildings in Raqqa, Syria, the Islamic State’s de facto capital.</p>\n                 <p>Mr. Hussain, a 21-year-old from Birmingham, England, was a leader of a band of English-speaking computer specialists who had given a far-reaching megaphone to Islamic State propaganda and exhorted online followers to carry out attacks in the West. One by one, American and allied forces have killed the most important of roughly a dozen members of the cell, which the F.B.I. calls “the Legion,” as part of a secretive campaign that has largely silenced a powerful voice that led to a surge of counterterrorism activity across the United States in 2015 as young men and women came under the influence of its propaganda.</p>\n                 <p>American military, intelligence and law enforcement officials acknowledge that the Islamic State still retains a sophisticated social media arm that could still inspire attacks like those in San Bernardino, Calif., and in Orlando, Fla., and remains a potent foe suspected of maintaining clandestine cells in Europe. But they point to the coordinated effort against the Legion as evidence of the success the United States has had in reducing the Islamic State’s ability to direct, enable or inspire attacks against the West.</p>"
        news.id = "1"
        array.add(news)
        let news1 = AKIContent()
        news1.header = "ISIS Bomb Aimed at Shiite Pilgrims in Iraq Kills at Least 80"
//        news1.dataText = "<p>ERBIL, Iraq — At least 80 people, many of them Shiite pilgrims on their way home to Iran, were killed on Thursday when an Islamic State suicide bomber detonated a truck filled with explosives at a roadside service station in southern Iraq, local officials said.</p><p>The devastating attack came two days after Prime Minister Haider al-Abadi applauded the security forces for protecting the millions of Shiites who have flowed through southern Iraq in recent days for what many consider the world’s largest religious pilgrimage, larger even than the hajj in Saudi Arabia.</p><p>In years past, the annual rite known as Arbaeen, a commemoration of the martyrdom of Imam Hussein, a revered seventh-century Shiite figure, was a frequent target of Sunni extremist groups like the Islamic State and its predecessor, Al Qaeda in Iraq.</p>"
        news1.id = "2"
        array.add(news1)
        
        let news2 = AKIContent()
        news2.id = "3"
        news2.header = "One Family. Six Decades. Myriad Views of Fidel Castro’s Revolution."
//        news2.dataText = "<p>HAVANA — When Fidel Castro rode victoriously into Havana on Jan. 8, 1959, Juan Montes Torre rushed into the streets to cheer. A poor, uneducated laborer from the eastern countryside of Cuba, he had arrived in the capital a few years earlier and, like most of his neighbors, could hardly believe what was happening.</p>\n                <p>“It was an emotional shock,” Mr. Montes said. “These bearded men, poorly dressed — they won! And on behalf of the lower classes!”</p>\n                <p>Mr. Montes, who was 25 at the time, stayed loyal to Mr. Castro, who died on Friday, from that moment. The Castro revolution gave him an education, a home, and a job as a police officer who sometimes guarded the comandante himself.</p>\n                <p>But that allegiance slipped from generation to generation in Mr. Montes’s family, and in Cuba as a whole. His son’s views darkened decades ago, during tussles with the Castro government’s restrictions. His teenage granddaughter, Rocio, has spent most of her youth feeling glum about the conditions in her country.</p>\n                <p>“There are too many Cubans who get up every day and struggle and struggle, and that’s it,” she said in an interview. “My dream is to leave.”</p>"
        array.add(news2)
        
        self.user?.newsArray = array
        self.newsView?.tableView?.reloadData()
    }
}
