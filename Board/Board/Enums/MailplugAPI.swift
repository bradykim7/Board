//
//  Url.swift
//  Board
//
//  Created by min seok Kim on 5/6/24.
//

enum MailplugAPI {
    case getBase
    case getToken

    private var baseURL: String {
//                return "https://mp-dev.mail-server.kr/api/v2/boards"
//                return "https://bbs.wiro.kr/api/v2/boards"
//                return "https://719166d8-4e43-4a1b-814a-949362b9afac.mock.pstmn.io/api/v2"

        return "https://bbs.mail-server.kr/api/v2"
    }
    
    private var Token: String {
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTYwMTc2OTAsImV4cCI6MTcxNjAxOTQ5MCwidXNlcm5hbWUiOiJnd25vMDFAZ3QwMS5teXBsdWcua3IiLCJzY29wZSI6WyJtYWlsIiwiYWRkcmVzc2Jvb2siLCJjYWxlbmRhciIsImJvYXJkIiwic21zIiwibWVzc2VuZ2VyIiwiZWFzIiwiZHJpdmUiLCJ3b3Jrbm90ZSIsIm9yZ2FuaXphdGlvbiIsInRhc2siLCJyZXNlcnZlIiwiaHJtIl0sInNlcnZpY2VJZCI6MTQ0Njg3NywiZ29vZHMiOiJHV19ERURJIiwiYWNjb3VudE5hbWUiOiJcdWFkMDBcdWI5YWNcdWM3OTAiLCJjbGllbnRJUCI6IjExOS43MC4xMjAuNDciLCJqdGkiOiIzYTk5In0.iskKL5vK9pZvsREKAR_IwX5kHzDmSMirwNqRlzY3F2I"
    }
    
    var path: String {
        switch self {
        case .getBase:
            return baseURL
        case .getToken:
            return Token
        }
        
    }
}
