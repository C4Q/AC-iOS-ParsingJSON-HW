//  Contact.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by Winston Maragh on 11/16/17.
//  Copyright © 2017 Winston Maragh . All rights reserved.

import Foundation


struct ContactResultsWrapper: Codable {
	let results: [Contact]
}

struct Contact: Codable {
	let gender: String
	let name: NameWrapper
	let location: LocationWrapper
	let email: String
	let login: LoginWrapper
	let dob: String
	let registered: String
	let phone: String
	let cell: String
	let picture: PictureWrapper
}

struct NameWrapper: Codable {
	let title: String
	let first: String
	let last: String
}

struct LocationWrapper: Codable {
	let street: String
	let city: String
	let state: String
	let postcode: String
}

struct LoginWrapper: Codable {
	let username: String
	let password: String
}

struct PictureWrapper: Codable {
	let large: String //"https://randomuser.me/api/portraits/men/83.jpg"
	let medium: String //"https://randomuser.me/api/portraits/med/men/83.jpg"
	let thumbnail: String //"https://randomuser.me/api/portraits/thumb/men/83.jpg"
}
