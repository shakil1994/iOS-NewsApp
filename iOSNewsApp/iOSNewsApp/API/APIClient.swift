import Foundation

enum CustomError: Error {
    case responseError(desp: String)
}

class APIClient {
    private let newsSourceUrl = URL(string: "https://newsapi.org/v2/sources?apiKey=7cc6f9c8dfa44fe993467007ada10a9e")

    private let newsUrl = URL(string: "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=7cc6f9c8dfa44fe993467007ada10a9e")

    func getNewsSource(_ completion: @escaping (Result<WebSite, CustomError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: newsSourceUrl!) { (data, response, error) in
            if let err = error {
                completion(.failure(CustomError.responseError(desp: err.localizedDescription)))
            }
            guard let result = data else {
                completion(.failure(CustomError.responseError(desp: "No respinse from server")))
                return
            }
            do {
                let news = try JSONDecoder().decode(WebSite.self, from: result)
                completion(.success(news))
            } catch {
                completion(.failure(CustomError.responseError(desp: error.localizedDescription)))
            }
        }
        task.resume()
    }
    
//    func getNews(_ completion: @escaping (Data) -> Void) {
//        let request = URLRequest(url: newsUrl!)
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if error != nil || data == nil {
//                print("Server Error")
//                return
//            }
//
//            guard let data = data else {
//                print("Response Error")
//                return
//            }
//            //print(String(data: data, encoding: .utf8)!)
//            completion(data)
//        }
//        task.resume()
//    }
    
    func getNews(_ completion: @escaping (Result<News, CustomError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: newsUrl!) { (data, response, error) in
            if let err = error {
                completion(.failure(CustomError.responseError(desp: err.localizedDescription)))
            }
            guard let result = data else {
                completion(.failure(CustomError.responseError(desp: "No respinse from server")))
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: result)
                completion(.success(news))
            } catch {
                completion(.failure(CustomError.responseError(desp: error.localizedDescription)))
            }
        }
        task.resume()
    }
}
