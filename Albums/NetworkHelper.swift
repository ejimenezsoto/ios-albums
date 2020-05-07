//
//  NetworkHelper.swift
//  Albums
//
//  Created by Enzo Jimenez-Soto on 5/7/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import Foundation
import Foundation

/// HTTPMethod is an enum that holds the strings of possible HTTP Request Methods. Use .rawValue instead of writing a string.
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

typealias CompletionHandler = (Error?) -> Void
