//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

struct Stock: Codable {
	let date: String //"2015-11-11"
	let open: Double //116.37,
	let high: Double //117.42
	let low: Double //115.21
	let close: Double //116.11
	let volume: Int //45217971
	let unadjustedVolume: Int //":45217971
	let change: Double //-0.66
	let changePercent: Double //-0.565
	let vwap: Double //116.3069
	let label: String //"Nov 11, 15"
	let changeOverTime: Double //0
}

