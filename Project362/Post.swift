//
//  DataManager.swift
//  Project362
//
//  Created by Kameron Carr on 3/3/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import Foundation

struct Post { 
	let postID: String
	let name: String
	let price: Double
	let swipes: Int	
	let location: String
	let comments: String
	
	init?(postID: String, dict: [String: Any]) {
		self.postID = postID
		
		guard let name = dict["name"] as? String,
		let price = dict["price"] as? Double,
		let swipes = dict["swipes"] as? Int,
		let location = dict["location"] as? String,
        let comments = dict["comments"] as? String else{
            fatalError()
        }
		
		self.name = name
		self.price = price
		self.swipes = swipes
		self.location = location
		self.comments  = comments
	}	
}	
