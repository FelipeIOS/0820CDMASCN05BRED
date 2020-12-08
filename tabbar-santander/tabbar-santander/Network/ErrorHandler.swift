//
//  ErrorHandler.swift
//  tabbar-santander
//
//  Created by Felipe Miranda on 07/12/20.
//

import Foundation


protocol ErrorProtocol: LocalizedError {
    
    var title:String? {get}
    var code: Int? {get}
    
}

struct ErrorHandler: ErrorProtocol {
    
    var title: String?
    var code: Int?
    var errorDescription: String? { return description}
//    var failureReason: String? {return description}
    private var description: String?
    
    init(title: String?, description: String?, code: Int?) {
        
        self.title =  title ?? "Error"
        self.description = description
        self.code = code ?? 400
    }
    
    init() {
        
        
    }
    
    init(dic: [String: Any]?) {
        
        if let _dic  = dic {
    
            let dicResponse:[String:Any]? = _dic["response"] as? [String : Any]
            
            let dicBody:[String:Any]? = dicResponse?["body"] as? [String : Any]
            
            if let _dicBody = dicBody {
               
                self.title = _dicBody["error"] as? String
                self.description = _dicBody["error_description"] as? String ?? ""
                self.code = dicResponse?["status"] as? Int
                
            }
        }
        
    }
    
}
