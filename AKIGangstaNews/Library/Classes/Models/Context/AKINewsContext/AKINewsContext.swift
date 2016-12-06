	//
//  AKINewsContext.swift
//  AKIGangstaNews
//
//  Created by Alexey Khomych on 05.12.16.
//  Copyright © 2016 Alexey Khomych. All rights reserved.
//

import UIKit
import Alamofire

class AKINewsContext: AKIContext {
    
    let constants = AKIConstants()
    
    func newsRequest() {
        let user = self.model as? AKIUser
        
        let url: String = "\(self.constants.kAKIAPIURL)\(self.constants.kAKINewsRequest)"
        
        let headers: HTTPHeaders = [
            self.constants.kAKIContentType: self.constants.kAKIApplicationJSON,
//            self.constants.kAKIAuthorization: "\(self.constants.kAKIBearerRequest) \(user?.authKey)"
            self.constants.kAKIAuthorization: "\(self.constants.kAKIBearerRequest) UmPblB9MPejCtetfQOH49rtfO-VtpIrC"
        ]
        
        self.request(url: url, headers: headers)
        
    }
    
    private func request(url: String, headers: HTTPHeaders) {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch(response.result) {
            case .success(_):
                if let json = response.result.value as? NSDictionary {
                    //modelDidLoad
                    
                    guard let data = json.object(forKey: "data") as? [Any] else { return }
                    
                    let user = self.model as? AKIUser
                    let array = NSMutableArray()
                    
                    for category in data {
                        guard let dictionary = category as? [String: Any] else { return }
                        let content = AKIContent()
                        content.header = dictionary["title"] as! String?
                        let imageUrl = dictionary["image_thumb"] as! String?
                        array.add(content)
                    }
                    
                    user?.newsArray = array
                }
                break
                
            case .failure(_):
                //modelDidFailLoading
                print(response.result.value as Any)
                break
                
            }
        }
    }

}

/*
 {
 "success": true,
 "data": [
 {
 "id": 1,
 "title": "One by One, ISIS Social Media Experts Are Killed as Result of F.B.I. Program",
 "short_desc": "American officials say a secretive campaign of surveillance and drone attacks has cut the Islamic State’s ability to inspire attacks in the West.",
 "desc": "<p>WASHINGTON — In the summer of 2015, armed American drones over eastern Syria stalked Junaid Hussain, an influential hacker and recruiter for the Islamic State.</p>\n                 <p>For weeks, Mr. Hussain was careful to keep his young stepson by his side, and the drones held their fire. But late one night, Mr. Hussain left an internet cafe alone, and minutes later a Hellfire missile killed him as he walked between two buildings in Raqqa, Syria, the Islamic State’s de facto capital.</p>\n                 <p>Mr. Hussain, a 21-year-old from Birmingham, England, was a leader of a band of English-speaking computer specialists who had given a far-reaching megaphone to Islamic State propaganda and exhorted online followers to carry out attacks in the West. One by one, American and allied forces have killed the most important of roughly a dozen members of the cell, which the F.B.I. calls “the Legion,” as part of a secretive campaign that has largely silenced a powerful voice that led to a surge of counterterrorism activity across the United States in 2015 as young men and women came under the influence of its propaganda.</p>\n                 <p>American military, intelligence and law enforcement officials acknowledge that the Islamic State still retains a sophisticated social media arm that could still inspire attacks like those in San Bernardino, Calif., and in Orlando, Fla., and remains a potent foe suspected of maintaining clandestine cells in Europe. But they point to the coordinated effort against the Legion as evidence of the success the United States has had in reducing the Islamic State’s ability to direct, enable or inspire attacks against the West.</p>\n                ",
 "image": "images/news/1/full.jpg",
 "category_id": 1,
 "created_at": null,
 "image_thumb": "images/news/1/thumb.jpg"
 },
 {
 "id": 2,
 "title": "ISIS Bomb Aimed at Shiite Pilgrims in Iraq Kills at Least 80",
 "short_desc": "The pilgrims, who were returning to Iran after a journey to observe Arbaeen, were killed by a truck bomb at a roadside service station.",
 "desc": "<p>ERBIL, Iraq — At least 80 people, many of them Shiite pilgrims on their way home to Iran, were killed on Thursday when an Islamic State suicide bomber detonated a truck filled with explosives at a roadside service station in southern Iraq, local officials said.</p><p>The devastating attack came two days after Prime Minister Haider al-Abadi applauded the security forces for protecting the millions of Shiites who have flowed through southern Iraq in recent days for what many consider the world’s largest religious pilgrimage, larger even than the hajj in Saudi Arabia.</p><p>In years past, the annual rite known as Arbaeen, a commemoration of the martyrdom of Imam Hussein, a revered seventh-century Shiite figure, was a frequent target of Sunni extremist groups like the Islamic State and its predecessor, Al Qaeda in Iraq.</p>",
 "image": "images/news/2/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/2/thumb.jpg"
 },
 {
 "id": 3,
 "title": "news 3",
 "short_desc": "short desc for news 3",
 "desc": "desc for news 3",
 "image": "images/news/3/full.jpg",
 "category_id": 1,
 "created_at": null,
 "image_thumb": "images/news/3/thumb.jpg"
 },
 {
 "id": 4,
 "title": "One Family. Six Decades. Myriad Views of Fidel Castro’s Revolution.",
 "short_desc": "Fidel Castro after arriving in Havana on Jan. 8, 1959. Mr. Castro’s revolution was welcomed by Cubans like Juan Montes Torre, a poor laborer at the time. “It was an emotional shock,” Mr. Montes recalled. “These bearded men, poorly dressed — they won! And ",
 "desc": "<p>HAVANA — When Fidel Castro rode victoriously into Havana on Jan. 8, 1959, Juan Montes Torre rushed into the streets to cheer. A poor, uneducated laborer from the eastern countryside of Cuba, he had arrived in the capital a few years earlier and, like most of his neighbors, could hardly believe what was happening.</p>\n                <p>“It was an emotional shock,” Mr. Montes said. “These bearded men, poorly dressed — they won! And on behalf of the lower classes!”</p>\n                <p>Mr. Montes, who was 25 at the time, stayed loyal to Mr. Castro, who died on Friday, from that moment. The Castro revolution gave him an education, a home, and a job as a police officer who sometimes guarded the comandante himself.</p>\n                <p>But that allegiance slipped from generation to generation in Mr. Montes’s family, and in Cuba as a whole. His son’s views darkened decades ago, during tussles with the Castro government’s restrictions. His teenage granddaughter, Rocio, has spent most of her youth feeling glum about the conditions in her country.</p>\n                <p>“There are too many Cubans who get up every day and struggle and struggle, and that’s it,” she said in an interview. “My dream is to leave.”</p>\n                ",
 "image": "images/news/4/full.jpg",
 "category_id": 1,
 "created_at": null,
 "image_thumb": "images/news/4/thumb.jpg"
 },
 {
 "id": 5,
 "title": "Can Oil Help Mexico Withstand Trump’s Attack on Trade? It’s Hard to See How",
 "short_desc": "CIUDAD DEL CARMEN, Mexico — The town that oil built is emptying out. “For Sale” signs are plastered on concrete-block houses and sun-bleached bungalows alike. ",
 "desc": "<p>“For Sale” signs are plastered on concrete-block houses and sun-bleached bungalows alike. The idled oil workers who used to cluster in the main square, hoping to pick up odd jobs, have moved on.</p>\n                <p>Here in Ciudad del Carmen, on the gulf coast of Mexico, even the ironclad union positions are slipping away. Some roughnecks on the offshore rigs of the national oil company, Pemex, have not worked in months, and their voices are filled with anxiety.</p>\n                <p>Pemex has been limping along for years, bleeding billions of dollars annually, saddled with debt and struggling to maintain production as its giant oil fields in the Gulf of Mexico run dry. Next year, it will pump less than two million barrels a day, the lowest output since 1980.</p>\n                <p>Fixing the oil company was already at the top of Mexico’s list of priorities, the focus of a long debate over the fate of one of its most important — and troubled — national institutions.</p>\n                ",
 "image": "images/news/5/full.jpg",
 "category_id": 1,
 "created_at": null,
 "image_thumb": "images/news/5/thumb.jpg"
 },
 {
 "id": 6,
 "title": "Israel Defense Forces Kill 4 ISIS-Linked Attackers in Golan Heights",
 "short_desc": "The firefight, near Syria, appeared to be the first deadly exchange between Israeli forces and fighters associated with the Islamic State.",
 "desc": "<p>JERUSALEM — The Israeli military said it killed four militants linked to the Islamic State on Sunday after they attacked Israeli forces in the Golan Heights.</p>\n                <p>The confrontation appeared to be the first of its kind between Israel and Islamic State-affiliated forces based in Syria. It was not immediately clear if the militants’ attack had been spontaneous or if it signaled a possible change of policy by extremist groups.</p>\n                <p>Lt. Col. Peter Lerner, a spokesman for the Israeli military, described the exchange as “unique” in magnitude. He said jihadist fighters, riding in a vehicle with a machine gun mounted on its roof, had assaulted an Israeli reconnaissance unit with gunfire and mortars on the Israeli-controlled side of the contested territory.</p>\n                <p>Prime Minister Benjamin Netanyahu of Israel said the soldiers had “successfully repelled an attempted attack on the triangle of borders,” or the point where Israel, Syria and Jordan converge. Using the Arabic acronym for Islamic State, he added, “We will not let Daesh elements or other hostile elements use the cover of the war in Syria to establish themselves next to our borders.”</p>\n                <p>Israel has generally tried to keep out of the Syrian civil war, declaring neutrality in the struggle between President Bashar al-Assad and rebel forces. But Israel has carried out a covert campaign to prevent the transfer of sophisticated weapons from Syria to Hezbollah, the Lebanese Shiite militant group that is aiding Mr. Assad and is an enemy of the Islamic State. And, intentionally or not, the fighting in the Syrian Golan Heights has occasionally spilled over into the Israeli-held part.</p>\n                ",
 "image": "images/news/6/full.jpg",
 "category_id": 1,
 "created_at": null,
 "image_thumb": "images/news/6/thumb.jpg"
 },
 {
 "id": 7,
 "title": "Combative, Populist Steve Bannon Found His Man in Donald Trump",
 "short_desc": "Mr. Bannon courted politicians who share his dark, populist worldview of a ruling class preying on working Americans and “the Judeo-Christian West” in a war against Islamic fascism.",
 "desc": "<p>When Julia Jones arrived at her office in Santa Monica at 8 a.m. — by Hollywood screenwriter standards, the crack of dawn — she found Stephen K. Bannon already at his desk, which was cluttered with takeout coffees. They were co-writers on a Ronald Reagan documentary, but Mr. Bannon had pretty much taken it over. He had been at work for hours, he told her, writing feverishly about his political hero.</p>\n                <p>Today, with Donald J. Trump, whose election Mr. Bannon helped engineer, on the threshold of power, the 2004 film “In the Face of Evil” has a prophetic ring. Its trailer has an over-the-top, apocalyptic feel: lurid footage of bombs dropping on cities alternating with grainy clips of Reagan speeches, as a choir provides a soaring soundtrack. The message: Only one man was up to the challenge posed by looming domestic and global threats.</p>\n                <p>“A man with a vision,” the trailer says. “An outsider, a radical with extreme views.”</p>\n                ",
 "image": "images/news/7/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/7/thumb.jpg"
 },
 {
 "id": 8,
 "title": "Cities Vow to Fight Trump on Immigration, Even if They Lose Millions",
 "short_desc": "Officials in what are known as sanctuary cities say they will act as a bulwark against mass deportations, even at the risk of losing federal money for local services.",
 "desc": "<p>LOS ANGELES — Here in Los Angeles, where nearly half of the city’s residents are Latino, Mayor Eric Garcetti has vowed to do everything he can to fight widespread deportations of illegal immigrants.</p>\n                <p>In New York, with a large and diverse Latino population, Mayor Bill de Blasio has pledged not to cooperate with immigration agents. And Mayor Rahm Emanuel of Chicago has declared that it “will always be a sanctuary city.”</p>\n                <p>Across the nation, officials in sanctuary cities are gearing up to oppose President-elect Donald J. Trump if he follows through on a campaign promise to deport millions of illegal immigrants. They are promising to maintain their policies of limiting local law enforcement cooperation with federal immigration agents.</p>\n                <p>In doing so, municipal officials risk losing millions of dollars in federal assistance for their cities that helps pay for services like fighting crime and running homeless shelters. Mr. Trump has vowed to block all federal funding for cities where local law enforcement agencies do not cooperate with Immigrations and Customs Enforcement agents.</p>\n                ",
 "image": "images/news/8/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/8/thumb.jpg"
 },
 {
 "id": 9,
 "title": "Obama Expands War With Al Qaeda to Include Shabab in Somalia",
 "short_desc": "The administration’s move to stretch a 2001 war authorization will strengthen Donald J. Trump’s authority to combat thousands of Somali militants, and has drawn objections from some experts.",
 "desc": "<p>WASHINGTON — The escalating American military engagement in Somalia has led the Obama administration to expand the legal scope of the war against Al Qaeda, a move that will strengthen President-elect Donald J. Trump’s authority to combat thousands of Islamist fighters in the chaotic Horn of Africa nation.</p>\n                <p>The administration has decided to deem the Shabab, the Islamist militant group in Somalia, to be part of the armed conflict that Congress authorized against the perpetrators of the Sept. 11, 2001, terrorist attacks, according to senior American officials. The move is intended to shore up the legal basis for an intensifying campaign of airstrikes and other counterterrorism operations, carried out largely in support of African Union and Somali government forces.</p>\n                <p>The executive branch’s stretching of the 2001 war authorization against the original Al Qaeda to cover other Islamist groups in countries far from Afghanistan — even ones, like the Shabab, that did not exist at the time — has prompted recurring objections from some legal and foreign policy experts.</p>\n                <p>The Shabab decision is expected to be publicly disclosed next month in a letter to Congress listing global deployments. It is part of the Obama administration’s pattern of relaxing various self-imposed rules for airstrikes against Islamist militants as it tries to help its partner forces in several conflicts.</p>\n                <p>In June, the administration quietly broadened the military’s authority to carry out airstrikes in Afghanistan to encompass operations intended “to achieve strategic effects,” meaning targeting people impeding the work of Afghan government forces, officials said. Previously, strikes in Afghanistan were permitted only in self-defense, for counterterrorism operations targeting Qaeda or Islamic State forces, or to “prevent a strategic defeat” of Afghan forces.</p>\n                ",
 "image": "images/news/9/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/9/thumb.jpg"
 },
 {
 "id": 10,
 "title": "White Women Helped Elect Donald Trump",
 "short_desc": "While black and Hispanic or Latino women voted overwhelmingly for Hillary Clinton, 53 percent of white women who voted picked Mr. Trump, exit data show.",
 "desc": "<p>More than half of the white women who voted in the presidential election cast their ballot for Donald J. Trump, according to exit poll data collected by The New York Times.</p>\n                 <p>The data indicate how deeply divided Americans are by race and gender: 94 percent of black women who voted and 68 percent of Hispanic or Latino female voters chose Hillary Clinton, but 53 percent of all white female voters picked Mr. Trump.</p>\n                 <p>The data can be broken down further: 51 percent of white women with college degrees voted for Mrs. Clinton, while 62 percent of women without one voted for Mr. Trump, a reflection of his success with working-class whites.</p>\n                 <p>“What leads a woman to vote for a man who has made it very clear that he believes she is subhuman?” Ms. Anderson wrote. “Self-loathing. Hypocrisy. And, of course, a racist view of the world that privileges white supremacy over every other issue.”</p>\n                 <p>The New York Daily News suggested that America should blame white women for Mrs. Clinton’s stunning loss. (Sixty-three percent of white men voted for Mr. Trump, with 54 percent with a college degree choosing him, along with 72 percent of white men without a college degree.)</p>\n                ",
 "image": "images/news/10/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/10/thumb.jpg"
 },
 {
 "id": 11,
 "title": "Betsy DeVos and the Wrong Way to Fix Schools",
 "short_desc": "Donald Trump’s choice to be education secretary was an architect of school reforms in Michigan. The results were terrible.",
 "desc": "<p>NEW ORLEANS — President-elect Donald J. Trump’s selection of Betsy DeVos as secretary of education has sent shock waves through the educational establishment. Understandably so, since this is a clear sign that Mr. Trump intends a major national push to direct public funds to private and charter schools. But this is more than just a political or financial loss for traditional public schools. It will also most likely be a loss for students.</p>\n                 <p>The choice of Ms. DeVos might not seem surprising. Mr. Trump has, after all, proposed $20 billion to finance “school choice” initiatives and Ms. DeVos supports these ideas. Yet of all the candidates the transition team was apparently considering, Ms. DeVos has easily the worst record.</p>\n                 <p>As one of the architects of Detroit’s charter school system, she is partly responsible for what even charter advocates acknowledge is the biggest school reform disaster in the country. At least some of the other candidates for education secretary, like Michelle Rhee, the former District of Columbia schools chancellor, led reforms that were accompanied by improved student results.</p>\n                 <p>Consider this: Detroit is one of many cities in the country that participates in an objective and rigorous test of student academic skills, called the National Assessment of Educational Progress. The other cities participating in the urban version of this test, including Baltimore, Cleveland and Memphis, are widely considered to be among the lowest-performing school districts in the country.</p>\n                 <p>Detroit is not only the lowest in this group of lowest-performing districts on the math and reading scores, it is the lowest by far. One well-regarded study found that Detroit’s charter schools performed at about the same dismal level as its traditional public schools. The situation is so bad that national philanthropists interested in school reform refuse to work in Detroit. As someone who has studied the city’s schools and used to work there, I am saddened by all this.</p>\n                 <p>The situation is not entirely Ms. DeVos’s fault, of course, but she is widely seen as the main driver of the entire state’s school overhaul. She devised Detroit’s system to run like the Wild West. It’s hardly a surprise that the system, which has almost no oversight, has failed. Schools there can do poorly and still continue to enroll students. Also, after more than a decade of Ms. DeVos’s getting her way on a host of statewide education policies, Michigan has the dubious distinction of being one of five states with declining reading scores.</p>\n                ",
 "image": "images/news/11/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/11/thumb.jpg"
 },
 {
 "id": 12,
 "title": "Hillary Clinton’s Team to Join Wisconsin Recount Pushed by Jill Stein",
 "short_desc": "The campaign also said it would participate in potential recounts in Pennsylvania and Michigan, though it saw no “actionable evidence” of vote hacking.",
 "desc": "<p>WASHINGTON — Nearly three weeks after Election Day, Hillary Clinton’s campaign said on Saturday that it would participate in a recount process in Wisconsin incited by a third-party candidate and would join any potential recounts in two other closely contested states, Pennsylvania and Michigan.</p>\n                 <p>The Clinton campaign held out little hope of success in any of the three states, and said it had seen no “actionable evidence” of vote hacking that might taint the results or otherwise provide new grounds for challenging Donald J. Trump’s victory. But it suggested it was going along with the recount effort to assure supporters that it was doing everything possible to verify that hacking by Russia or other irregularities had not affected the results.</p>\n                 <p>In a post on Medium, Marc Elias, the Clinton team’s general counsel, said the campaign would take part in the Wisconsin recount being set off by Jill Stein, the Green Party candidate, and would also participate if Ms. Stein made good on her plans to seek recounts in Michigan and Pennsylvania. Mrs. Clinton lost those three states by a total of little more than 100,000 votes, sealing her Electoral College defeat by Mr. Trump.</p>\n                 <p>The Clinton campaign had assailed Mr. Trump during the election for refusing to say he would abide by the results if he lost. On Saturday, Mr. Trump responded to the campaign’s decision to join the recount with a statement calling the effort “ridiculous” and “a scam by the Green Party.”</p>\n                 <p>He suggested that most of the money raised would not be spent on the recount. “The results of this election should be respected instead of being challenged and abused, which is exactly what Jill Stein is doing,” Mr. Trump said.</p>\n                 <p>In Wisconsin, Mr. Trump leads by 22,177 votes. In Michigan, he has a lead of 10,704 votes, and in Pennsylvania, his advantage is 70,638 votes.</p>\n                ",
 "image": "images/news/12/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/12/thumb.jpg"
 },
 {
 "id": 13,
 "title": "Fate of U.S.-Cuba Thaw Is Less Certain Under Donald Trump",
 "short_desc": "The president-elect has been critical of the détente, and sent mixed signals during the campaign about his intentions toward the island nation.",
 "desc": "<p>WASHINGTON — President Obama said on Saturday that the death of Fidel Castro was an occasion for Americans to “extend a hand of friendship to the Cuban people” and acknowledge the “powerful emotions” the revolutionary leader had evoked in both countries, seeking to use Mr. Castro’s fraught legacy to underscore his own efforts to bury decades of bitterness between the United States and Cuba.</p>\n                 <p>“History will record and judge the enormous impact of this singular figure on the people and world around him,” Mr. Obama said in a statement that neither criticized nor praised Mr. Castro. “The Cuban people,” he added, “must know that they have a friend and partner in the United States of America.”</p>\n                 <p>The death of Mr. Castro, the embodiment of decades of suspicion and enmity between the two countries, has the potential to hasten Mr. Obama’s goal of cementing the historic rapprochement that he hopes will be a signature part of his legacy.</p>\n                 <p>But with Donald J. Trump, who has been critical of the détente, set to succeed Mr. Obama, the fate of the thaw between the United States and Cuba is far from clear. Mr. Trump’s initial response on the matter Saturday morning was a four-word post on Twitter. “Fidel Castro is dead!” he wrote.</p>\n                 <p>A few hours later, in a statement issued by his transition team, Mr. Trump called Mr. Castro a “brutal dictator” who had oppressed his own people for decades and left a legacy of “firing squads, theft, unimaginable suffering, poverty and the denial of fundamental human rights.”</p>\n                 <p>“While Cuba remains a totalitarian island, it is my hope that today marks a move away from the horrors endured for too long, and toward a future in which the wonderful Cuban people finally live in the freedom they so richly deserve,” Mr. Trump said. “Though the tragedies, deaths and pain caused by Fidel Castro cannot be erased, our administration will do all it can to ensure the Cuban people can finally begin their journey toward prosperity and liberty.”</p>\n                ",
 "image": "images/news/13/full.jpg",
 "category_id": 2,
 "created_at": null,
 "image_thumb": "images/news/13/thumb.jpg"
 }
 ]
 }*/
