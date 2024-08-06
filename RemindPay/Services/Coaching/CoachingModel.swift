//
//  CoachingModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation


import UIKit

enum Coaching {

    enum Fetch {

        struct Request {

        }

        struct Response {

        }

        struct ViewModel {

        }
    }

    enum Refresh {

        struct Request {

        }

        struct Response {

        }

        struct ViewModel {

        }
    }

    enum Create {
        
        struct Request {
            
        }

        struct Response {

        }

        struct ViewModel {

        }
    }

    struct Update {

        struct Request {

        }

        struct Response {

        }

        struct ViewModel {

        }
    }

    struct User {
        let id: UUID
        let name, age, school, profileImage, planStart, planEnd: String
    }
}
