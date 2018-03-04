//
//  DataManager.swift
//  Project362
//
//  Created by Kameron Carr on 3/3/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import Foundation
import Firebase

struct PostsSnapshot { 
	let posts: [Post]
	
	init?(with snapshot: DataSnapshot) {
		var posts = [Post]()
		guard let snapDict = snapshot.value as? [String: [String: Any]] //This line isn't working
            else { return nil }
		for snap in snapDict {
            guard let post = Post(postID: snap.key, dict: snap.value) else { fatalError() }
			posts.append(post)
		}
		self.posts = posts
	}
}	
