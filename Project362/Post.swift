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
	let price: Sring
	let swipes: String	
	let location: String
	let time: String
	let phoneNumber: String
	let comments: String
	let buyer: Boolean
	
	
	init?(postID: String, dict: [String: Any]) {
		self.postID = postID
		
		guard let name = dict["name"] as? String,
		let price = dict["price"] as? String,
		let swipes = dict["swipes"] as? String,
		let location = dict["location"] as? String,
		let time = dict["time"] as? String,
		let phoneNumber = dict["phoneNumber"] as? String,
        let comments = dict["comments"] as? String, 
		let buyer = dict["buyer"] as? Boolean
		else { fatalError() }
		
		self.name = name
		self.price = price
		self.swipes = swipes
		self.location = location
		self.time = time
		self.phoneNumber = phoneNumber
		self.comments  = comments
		self.buyer = buyer
	}	
}	
