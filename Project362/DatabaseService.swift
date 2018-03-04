//
//  DataManager.swift
//  Project362
//
//  Created by Kameron Carr on 3/3/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
	static let shared = DatabaseService()
	private init() {}
	
	let postsReference = Database.database().reference().child("post")
}
