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
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTYxNzIwMTAsImV4cCI6MTcxNjE3MzgxMCwidXNlcm5hbWUiOiJnd25vMDFAZ3QwMS5teXBsdWcua3IiLCJzY29wZSI6WyJtYWlsIiwiYWRkcmVzc2Jvb2siLCJjYWxlbmRhciIsImJvYXJkIiwic21zIiwibWVzc2VuZ2VyIiwiZWFzIiwiZHJpdmUiLCJ3b3Jrbm90ZSIsIm9yZ2FuaXphdGlvbiIsInRhc2siLCJyZXNlcnZlIiwiYWRtaW4iLCJocm0iXSwic2VydmljZUlkIjoxNDQ2ODc3LCJnb29kcyI6IkdXX0RFREkiLCJhY2NvdW50TmFtZSI6Ilx1YWQwMFx1YjlhY1x1Yzc5MCIsImNsaWVudElQIjoiMjIwLjg1LjIxLjM1IiwianRpIjoiNzdmZiJ9.7nuHfAWDGs0b5KPKGjMdUWNbi5rlZqbUh0oPY8l9Low"
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
