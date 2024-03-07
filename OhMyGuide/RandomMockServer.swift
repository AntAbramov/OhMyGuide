//
//  RandomMockServer.swift
//  OhMyGuide
//
//  Created by Anton Abramov on 07.03.2024.
//

import Foundation

final class RandomMockServer {
    private let queue = DispatchQueue(label: "DataSourceQueue")
    
    func subscribeToUpdates(completion: @escaping ([[Int]]) -> Void) {
        var defaultDataSource = [[Int]]()
        for _ in 0...100 {
            let randomInt = Int.random(in: 11...30)
            let temp = (0..<randomInt).map { _ in Int.random(in: 0...100) }
            defaultDataSource.append(temp)
        }
        
        queue.async {
            for _ in 0...100_000 {
                for (index, subArray) in defaultDataSource.enumerated() {
                    let randomValue = Int.random(in: 0...100)
                    let randomIndex = Int.random(in: 0..<subArray.count)
                    var tempSub = subArray
                    tempSub[randomIndex] = randomValue
                    defaultDataSource[index] = tempSub
                }
                
                DispatchQueue.main.async {
                    completion(defaultDataSource)
                }
                sleep(1)
            }
        }
    }
}
