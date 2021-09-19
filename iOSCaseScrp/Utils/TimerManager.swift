//
//  TimerManager.swift
//  iOSCase
//
//  Created by Mert Saraç on 19.09.2021.
//

import Foundation

struct TimerManagerConstants {
    static let timeIntervalThreshold = 15 as Double
    static let maxNumberOfRequestInTimeInterval = 2
}

class TimerManager {
    var recentRequests: [Date] = []
    
    func processRequest(checkTime: Bool, completion: (Bool) -> ()) {
        guard !checkTime else {
            completion(true)
            return
        }
        
        let currentDate = Date()
        
        var count = 0
        for timeInterval in recentRequests.reversed() {
            var timeInterval = currentDate.timeIntervalSince(timeInterval)
            if timeInterval < TimerManagerConstants.timeIntervalThreshold {
                count += 1
                print(count)
            }
        }

        if count >= TimerManagerConstants.maxNumberOfRequestInTimeInterval {
            completion(false)
            return
        }
        
        recentRequests.append(currentDate)
        while recentRequests.count > TimerManagerConstants.maxNumberOfRequestInTimeInterval + 1 {
            recentRequests.remove(at: 0)
        }
        
        print(recentRequests)
        completion(true)
    }
}
