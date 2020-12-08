//
//  GenericWorker.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 04/12/20.
//

import Foundation


enum Method:String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
class GenericWorker {

    typealias completion <T> = (_ result: T, _ failure: ErrorHandler?) -> Void
}
