//
//  MultipartFormDataHelper.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 13.12.24.
//


import Foundation
import UIKit

struct MultipartFormDataHelper {
    
    static func createRequest(url: URL,
                              method: String = "POST",
                              fields: [String: String],
                              image: UIImage? = nil,
                              imageFieldName: String = "photo",
                              imageFilename: String = "image.jpg",
                              boundary: String = "Boundary-\(UUID().uuidString)") -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Build multipart form body
        let httpBody = buildBody(boundary: boundary, fields: fields, image: image, imageFieldName: imageFieldName, imageFilename: imageFilename)
        request.httpBody = httpBody
        
        return request
    }
    
    private static func buildBody(boundary: String,
                                  fields: [String: String],
                                  image: UIImage?,
                                  imageFieldName: String,
                                  imageFilename: String) -> Data {
        
        var body = Data()
        
        // Append fields
        for (key, value) in fields {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        // Append image if present
        if let image = image,
           let imageData = image.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(imageFieldName)\"; filename=\"\(imageFilename)\"\r\n")
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
}

private extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}