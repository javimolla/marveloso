// APIs.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class SwaggerClientAPI {
    public static var basePath = "https://gateway.marvel.com/"
    public static var credential: URLCredential?
    public static var customHeaders: [String:String] = [:]
    public static var requestBuilderFactory: RequestBuilderFactory = AlamofireRequestBuilderFactory()
    public static var publicKey = ""
    public static var privateKey = ""
}

open class RequestBuilder<T> {
    var credential: URLCredential?
    var headers: [String:String]
    var parameters: [String:Any]?
    public let isBody: Bool
    public let method: String
    public let URLString: String

    /// Optional block to obtain a reference to the request's progress instance when available.
    public var onProgressReady: ((Progress) -> ())?

    required public init(method: String, URLString: String, parameters: [String:Any]?, isBody: Bool, headers: [String:String] = [:]) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.isBody = isBody
        self.headers = headers

        addHeaders(SwaggerClientAPI.customHeaders)
        
        addApiParameters()
    }

    open func addHeaders(_ aHeaders:[String:String]) {
        for (header, value) in aHeaders {
            headers[header] = value
        }
    }

    open func execute(_ completion: @escaping (_ response: Response<T>?, _ error: Error?) -> Void) { }

    public func addHeader(name: String, value: String) -> Self {
        if !value.isEmpty {
            headers[name] = value
        }
        return self
    }

    open func addCredential() -> Self {
        self.credential = SwaggerClientAPI.credential
        return self
    }
    
    private func addApiParameters() {
        if (self.parameters == nil) {
            self.parameters = [:]
        }
        let ts = String(Date().currentTimeMillis())
        self.parameters!["ts"] = ts
        self.parameters!["hash"] = getApiHash(ts)
        self.parameters!["apikey"] = SwaggerClientAPI.publicKey
    }
    
    private func getApiHash(_ ts: String) -> String {
        let toHash = ts + SwaggerClientAPI.privateKey + SwaggerClientAPI.publicKey
        return toHash.md5()
    }
}

public protocol RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type
    func getBuilder<T:Decodable>() -> RequestBuilder<T>.Type
}
