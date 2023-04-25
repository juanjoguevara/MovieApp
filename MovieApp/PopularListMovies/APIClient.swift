//
//  APIClient.swift
//  ViperSample
//
//  Created by Juan José Guevara Muñoz on 19/4/23.
//

import Foundation
enum ApiError: Error{
    case responseError
    case dataNilError
}

class ApiClient {
    class func getMovies(dataResponse:@escaping(Data?, Error?) -> ()){
        guard let postURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=665cfdf86dfa5cb374d33709e4c3dead&language=en-US&page=1")else{
            return
        }
        
        URLSession.shared.dataTask(with: postURL) { data, response, error in
            
            if (error != nil){
                dataResponse(nil,ApiError.responseError)
            }
            guard let receivedData = data else{
                dataResponse(nil,ApiError.dataNilError)
                return
            }
            dataResponse(receivedData, nil)
        }.resume()
    }
    
    class func searchMovies(query:String, dataResponse:@escaping(Data?, Error?) -> ()){
        
        let queryParam = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let queryString = "https://api.themoviedb.org/3/search/movie?api_key=665cfdf86dfa5cb374d33709e4c3dead&language=en-US&page=1&query=" + queryParam
        
        guard let postURL = URL(string: queryString)else{
            return
        }
        
        URLSession.shared.dataTask(with: postURL) { data, response, error in
            
            if (error != nil){
                dataResponse(nil,ApiError.responseError)
            }
            guard let receivedData = data else{
                dataResponse(nil,ApiError.dataNilError)
                return
            }
            dataResponse(receivedData, nil)
        }.resume()
        
    }
}
