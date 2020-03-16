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
    
    func getNews(source: String, completion: @escaping (Result<News, CustomError>) -> Void) {
        let str = "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=7cc6f9c8dfa44fe993467007ada10a9e"
        //print(str)
        guard let url = URL(string: str) else {
            completion(.failure(CustomError.responseError(desp: "Invalid URL")))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
