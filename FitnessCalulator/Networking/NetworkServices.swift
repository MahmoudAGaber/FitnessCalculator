//
//  NetworkServices.swift
//  FitnessCalulator
//
//  Created by MAG on 14/07/2023.
//

import Foundation


class NetworkServices{

    static let shared = NetworkServices()

    func getBIMCalculatro(completion: @escaping(Result<String, Error>) -> Void){
        request(route: .BMICalcualtor, method: .get, completion: completion)
    }

    private func request<T: Decodable>(route: Route,
                                       method: Method,
                                       parameters: [String: Any]? = nil,
                                       completion: @escaping(Result<T, Error>) -> Void) {

        let headers = [
            "X-RapidAPI-Host": "fitness-calculator.p.rapidapi.com",
            "X-RapidAPI-Key": "e47c7c931amsheb63e4c5dd57ce1p1da6d2jsncc1d44963412",
            "Content-Type": "application/json"
        ]

        guard let request = createRequest(route: route, method: method, parameters: parameters,headers: headers) else {
            completion(.failure(AppError.unknownError))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }

    private func handleResponse<T: Decodable>(result: Result<Data, Error>?,
                                              completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }

        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }

            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }

            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }

    /// This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: the path the the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil,
                               headers: [String: String]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)

        if let headers = headers {
                for (key, value) in headers {
                    urlRequest.addValue(value, forHTTPHeaderField: key)
                }
            }

        urlRequest.httpMethod = method.rawValue

        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
