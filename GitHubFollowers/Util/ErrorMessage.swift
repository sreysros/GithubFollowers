//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by SreySros on 1/8/22.
//

import Foundation

enum CustomError: String, Error {
    case invalidRequest = "This username created an invalid request, please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
