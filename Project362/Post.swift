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
	let price: String
	let swipes: String	
	let location: String
	let comments: String
	
	init(postID: String, dict: [String: Any]) {
		self.postID = postID
		
		guard let name = dict["name"] as? String,
		let price = dict["price"] as? String,
		let swipes = dict["swipes"] as? String,
		let location = dict["location"] as? String,
		let comments = dict["comments"] as? String,
		
		self.name = username
		self.price = price
		self.swipes = swipes
		self.location = location
		self.comments  = comments
	}	
}	