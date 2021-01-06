//
//  NetManager.swift
//  RichCat
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

typealias EWResponseSuccess = (_ response: AnyObject) -> Void
typealias EWResponseFail = (_ error: AnyObject) -> Void
typealias ELNetworkStatus = (_ EWNetworkStatus: Int32) -> Void

@objc enum EWNetworkStatus: Int32 {
    case unknown          = -1//未知网络
    case notReachable     = 0//网络无连接
    case wwan             = 1//2，3，4G网络
    case wifi             = 2//wifi网络
}
class NetManager: NSObject {
    static let ShareInstance = NetManager()
    private lazy var manager: SessionManager = {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            ///正式环境的证书配置,修改成自己项目的正式url
            "www.baidu.com": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            ),
            ///测试环境的证书配置,不验证证书,无脑通过
            "192.168.1.213:8002": .disableEvaluation
        ]
        config.httpAdditionalHeaders = ewHttpHeaders
        config.timeoutIntervalForRequest = ewTimeout
        //根据config创建manager
        return SessionManager(configuration: config,
                              delegate: SessionDelegate(),
                              serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
//    ///baseURL,可以通过修改来实现切换开发环境与生产环境
//     var ewPrivateNetworkBaseUrl: String = YMAppEnvDefine.serverUrl()
    ///默认超时时间
     var ewTimeout: TimeInterval = 25
    /**** 请求header
     *  根据后台需求,如果需要在header中传类似token的标识
     *  就可以通过在这里设置来实现全局使用
     *  这里是将token存在keychain中,可以根据自己项目需求存在合适的位置.
     */
    private var ewHttpHeaders: [String:String]? {
        //            guard let tokenData = Keychain.load(key: "token") else { return nil }
        //            let token = NSKeyedUnarchiver.unarchiveObject(with: tokenData)
        let userDefault = UserDefaults.standard
        let stringValue = userDefault.string(forKey: "Ticket") ?? ""
//        let stringValue =  "3DAB5092A62DCFCFE743F5D4B96653B7AF26A916CF362C292AF9B0045B8EAC87BC37858818604350733CC273528BA36909019CF96E14D585F20FC568CC5AED84071E4F0D257CEE94609A65B339F5ED2EDD7077398D607DE0199B717812A36917EA391A5A8D741ECD997B1296A14709DFC3B3A689278C199F08FE2120246A15CA3D99E261C4EBA0E91C5C42C0D959FD2832404441C557AF57D90F60AA56A51BF2126B4A6F0AABF27C07436978E868BBD5C8682EB517E4F8C7FB3330E2C3F8C001787AA8C7F9958C5D576E0A45C183DBFDBEA4FED96F1ABA0E71B9A9FFE4B2037F4384765A0BF3B11CD63F96F0F2EA39A09E298CC2521D354F94EFCE428E59D3E27731A7D844B5CA2FEA7ED6F53109B27432B34E8F1D6E745DF1F534BD6365E629CACCBE602F78E7DD70DF47DEE57E38C3280D1328ACF4D52250B2A584106FEB9E73A8854E3460B7C2E3F123CAD15D6E9C1A3A1EDED0579301E691832B2DB47460E84AA3442AC40A8B91100662D905F3D5ECDEF78E3ABA5C5504B0B1BCCA04AA19536C41B7FAC85092527DCF9C18B7C62E90EAD7B37693F72ACE5450E778AA662E"
        return ["Authorization": "Bearer " + stringValue]
    }
    ///缓存存储地址
    private  let cachePath = NSHomeDirectory() + "/Documents/AlamofireCaches/"
    ///当前网络状态
    private var ewNetworkStatus: EWNetworkStatus = EWNetworkStatus.wifi
    
    public func getWith(url: String,
                        params: [String: Any]?,
                        success: @escaping EWResponseSuccess,
                        error: @escaping EWResponseFail) {
        requestWith(url: url,
                    httpMethod: 0,
                    params: params,
                    success: success,
                    error: error)
    }
    public func postWith(url: String,
                         params: [String: Any]?,
                         success: @escaping EWResponseSuccess,
                         error: @escaping EWResponseFail) {
        requestWith(url: url,
                    httpMethod: 1,
                    params: params,
                    success: success,
                    error: error)
    }
    ///核心方法
    public func requestWith(url: String,
                            httpMethod: Int32,
                            params: [String: Any]?,
                            success: @escaping EWResponseSuccess,
                            error: @escaping EWResponseFail) {
        if (self.baseUrl() == nil) {
            if URL(string: url) == nil {
                print("URLString无效")
                return
            }
        } else {
            if URL(string: "\(self.baseUrl()!)\(url)" ) == nil {
                print("URLString无效")
                return
            }
        }
        let encodingUrl = encodingURL(path: url)
        let absolute = absoluteUrlWithPath(path: encodingUrl)
        let lastUrl = buildAPIString(path: absolute)
        //打印header进行调试.
        if let params = params {
            print("\(lastUrl)\nheader =\(String(describing: ewHttpHeaders!))\nparams = \(params)")
        } else {
            print("\(lastUrl)\nheader =\(String(describing: ewHttpHeaders!))")
        }
        //            //无网络状态获取缓存
        //                if ewNetworkStatus.rawValue == EWNetworkStatus.notReachable.rawValue
        //                    || ewNetworkStatus.rawValue == EWNetworkStatus.unknown.rawValue {
        //                    let response = self.cahceResponseWithURL(url: lastUrl,
        //                                                                     paramters: params)
        //                    if response != nil {
        //                        self.successResponse(responseData: response!, callback: success)
        //                    } else {
        //                        return
        //                    }
        //                }
        //get
        if httpMethod == 0 {
            
            manageGet(url: lastUrl, params: params, success: success, error: error)
        } else {
            managePost(url: lastUrl, params: params!, success: success, error: error)
        }
    }
    private func managePost(url: String,
                            params: [String: Any],
                            success: @escaping EWResponseSuccess,
                            error: @escaping EWResponseFail) {
        manager.request(url,
                        method: .post,
                        parameters: params,
                        encoding: JSONEncoding.default,
                        headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .success:
                                ///添加一些全部接口都有的一些状态判断
                                if let value = response.result.value as? [String: Any] {
                                    //                                        if value["status"] as? Int == 1010 {
                                    //                                            error("登录超时,请重新登录" as AnyObject)
                                    ////                                            _ = Keychain.clear()
                                    //                                            return
                                    //                                        }
                                    
                                    print("接口返回的 =\(value)")
                                    if value["code"] != nil {
                                        let code = value["code"] ?? 400
                                        if code as! Int  == 0 {
                                            success(value["data"] as AnyObject)
                                        }else{
                                            debugPrint(value["msg"] ?? "网络错误")
                                        }
                                    }else{
                                        debugPrint(value["msg"] ?? "网络错误")
                                    }
                                }
                            case .failure(let err):
                                error(err as AnyObject)
                                debugPrint(error)
                            }
        }
    }
    private func manageGet(url: String,
                           params: [String: Any]?,
                           success: @escaping EWResponseSuccess,
                           error: @escaping EWResponseFail) {
        manager.request(url,
                        method: .get,
                        parameters: params,
                        encoding: URLEncoding.default,
                        headers: nil).responseJSON { (response) in
                            switch response.result {
                            case .success:
                                if let value = response.result.value as? [String: Any] {
                                    ///添加一些全部接口都有的一些状态判断
                                    //                                        if value["status"] as? Int == 1010 {
                                    //                                            error("登录超时,请重新登录" as AnyObject)
                                    ////                                            _ = Keychain.clear()
                                    //                                            return
                                    //                                        }
                                    DLog("接口返回的 =\(value)")
                                    if value["code"] != nil {
                                        let code = value["code"] ?? 400
                                        if code as! Int  == 0 {
                                            success(value["data"] as AnyObject)
                                        }else{
                                            debugPrint(value["msg"] ?? "网络错误")
                                        }
                                    }else{
                                        debugPrint(value["msg"] ?? "网络错误")
                                    }
                                    
                                    //缓存数据
                                    //                                        self.cacheResponseObject(responseObject: value as AnyObject,request: response.request!,parameters: nil)
                                }
                            case .failure(let err):
                                error(err as AnyObject)
                                debugPrint(err)
                            }
        }
    }
}
// MARK: 网络状态相关
extension NetManager {
    ///监听网络状态
    public func detectNetwork(netWorkStatus: @escaping ELNetworkStatus) {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening()
        reachability?.listener = { [weak self] status in
            guard let weakSelf = self else { return }
            if reachability?.isReachable ?? false {
                switch status {
                case .notReachable:
                    weakSelf.ewNetworkStatus = EWNetworkStatus.notReachable
                case .unknown:
                    weakSelf.ewNetworkStatus = EWNetworkStatus.unknown
                case .reachable(.wwan):
                    weakSelf.ewNetworkStatus = EWNetworkStatus.wwan
                case .reachable(.ethernetOrWiFi):
                    weakSelf.ewNetworkStatus = EWNetworkStatus.wifi
                }
            } else {
                weakSelf.ewNetworkStatus = EWNetworkStatus.notReachable
            }
            netWorkStatus(weakSelf.ewNetworkStatus.rawValue)
        }
    }
    ///监听网络状态
    public func obtainDataFromLocalWhenNetworkUnconnected() {
        self.detectNetwork { (_) in
        }
    }
}
// MARK: 缓存数据相关
//    extension NetManager {
//        ///从缓存中获取数据
//        public func cahceResponseWithURL(url: String, paramters: [String: Any]?) -> Any? {
//            var cacheData: Any?
//            let directorPath = cachePath
//            let absoluteURL = self.generateGETAbsoluteURL(url: url, paramters)
//            ///使用md5进行加密
////            let key = absoluteURL.md5()
//            let path = directorPath.appending(absoluteURL)
//            let data: Data? = FileManager.default.contents(atPath: path)
//            if data != nil {
//                cacheData = data
//                print("Read data from cache for url: \(url)\n")
//            }
//            return cacheData
//        }
//        /// 进行数据缓存
//        ///
//        /// - Parameters:
//        ///   - responseObject: 缓存数据
//        ///   - request: 请求
//        ///   - parameters: 参数
//        public func cacheResponseObject(responseObject: AnyObject,
//                                        request: URLRequest,
//                                        parameters: [String: Any]?) {
//            if !(responseObject is NSNull) {
//                let directoryPath: String = cachePath
//                ///如果没有目录,那么新建目录
//                if !FileManager.default.fileExists(atPath: directoryPath, isDirectory: nil) {
//                    do {
//                        try FileManager.default.createDirectory(atPath: directoryPath,
//                                                                withIntermediateDirectories: true,
//                                                                attributes: nil)
//                    } catch let error {
//                        print("create cache dir error: " + error.localizedDescription + "\n")
//                        return
//                    }
//                }
//                ///将get请求下的参数拼接到url上
//                let absoluterURL = self.generateGETAbsoluteURL(url: (request.url?.absoluteString)!, parameters)
//                ///对url进行md5加密
////                let key = absoluterURL.md5()
//                ///将加密过的url作为目录拼接到默认路径
//                let path = directoryPath.appending(absoluterURL)
//                ///将请求数据转换成data
//                let dict: AnyObject = responseObject
//                var data: Data?
//                do {
//                    try data = JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//                } catch {
//                }
//                ///将data存储到指定路径
//                if data != nil {
//                    let isOk = FileManager.default.createFile(atPath: path,
//                                                              contents: data,
//                                                              attributes: nil)
//                    if isOk {
//                        print("cache file ok for request: \(absoluterURL)\n")
//                    } else {
//                        print("cache file error for request: \(absoluterURL)\n")
//                    }
//                }
//            }
//        }
//        ///解析缓存数据
//        public func successResponse(responseData: Any, callback success: EWResponseSuccess) {
//            success(self.tryToParseData(responseData: responseData))
//        }
//        ///解析数据
//        public func tryToParseData(responseData: Any) -> AnyObject {
//            guard let data = responseData as? Data else {
//                return responseData as AnyObject
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                return json as AnyObject
//            } catch {
//                return responseData as AnyObject
//            }
//        }
//    }
// MARK: url拼接相关
extension NetManager {
//    /// 更新baseURL
//    public func updateBaseUrl(baseUrl: String) {
//        ewPrivateNetworkBaseUrl = baseUrl
//    }
    /// 获取baseURL
    public func baseUrl() -> String? {
//        return YMAppEnvDefine.serverUrl()
        return "http://qmapicc.feicuisoft.com"
    }
    ///中文路径encoding
    public func encodingURL(path: String) -> String {
        return path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    ///拼接baseurl生成完整url
    public func absoluteUrlWithPath(path: String?) -> String {
        if path == nil
            || path?.length == 0 {
            return ""
        }
        if self.baseUrl() == nil
            || self.baseUrl()?.length == 0 {
            return path!
        }
        var absoluteUrl = path
        if !(path?.hasPrefix("http://"))!
            && !(path?.hasPrefix("https://"))! {
            if (self.baseUrl()?.hasPrefix("/"))! {
                if (path?.hasPrefix("/"))! {
                    var mutablePath = path
                    mutablePath?.remove(at: (path?.startIndex)!)
                    absoluteUrl = self.baseUrl()! + mutablePath!
                } else {
                    absoluteUrl = self.baseUrl()! + path!
                }
            } else {
                if (path?.hasPrefix("/"))! {
                    absoluteUrl = self.baseUrl()! + path!
                } else {
                    absoluteUrl = self.baseUrl()! + "/" + path!
                }
            }
        }
        return absoluteUrl!
    }
    /// 在url最后添加一部分,这里是添加的选择语言,可以根据需求修改.
    public func buildAPIString(path: String) -> String {
        if path.containsIgnoringCase(find: "http://")
            || path.containsIgnoringCase(find: "https://") {
            return path
        }
        let lang = "zh_CN"
        var str = ""
        if path.containsIgnoringCase(find: "?") {
            str = path + "&@lang=" + lang
        } else {
            str = path + "?@lang=" + lang
        }
        return str
    }
    /// get请求下把参数拼接到url上
    public func generateGETAbsoluteURL(url: String, _ params: [String: Any]?) -> String {
        guard let params = params else {return url}
        if params.count == EMPTY {
            return url
        }
        var url = url
        var queries = ""
        for key in (params.keys) {
            let value = params[key]
            if value is [String: Any] {
                continue
            } else if value is [Any] {
                continue
            } else if value is Set<AnyHashable> {
                continue
            } else {
                queries = queries.length == 0 ? "&" : queries + key + "=" + "\(value as? String ?? "")"
            }
        }
        if queries.length > 1 {
            queries = String(queries[queries.startIndex..<queries.endIndex])
        }
        if (url.hasPrefix("http://")
            || url.hasPrefix("https://")
            && queries.length > 1) {
            if url.containsIgnoringCase(find: "?")
                || url.containsIgnoringCase(find: "#") {
                url = "\(url)\(queries)"
            } else {
                queries = queries.stringCutToEnd(star: 1)
                url = "\(url)?\(queries)"
            }
        }
        return url.length == 0 ? queries : url
    }
}
