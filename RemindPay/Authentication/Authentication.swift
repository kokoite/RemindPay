//
//  User.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import Foundation

struct User: Codable {
    let id: UUID
    let name, phone, email, profileImageUrl: String
    let membership: MembershipType

    init(id: UUID, name: String, phone: String, email: String, profileImageUrl: String, membership: MembershipType) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.membership = membership
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.email = try container.decode(String.self, forKey: .email)
        self.profileImageUrl = try container.decode(String.self, forKey: .profileImageUrl)
        self.membership = try container.decode(MembershipType.self, forKey: .membership)
    }
}

enum MembershipType: Codable {
    case free
    case paid(value: Int)
}

enum Authentication {

    struct Create {
        
        struct Request {
            let user: User
        }

        struct Response {
            let state: State
        }
    }

    enum State {
        case success
        case error(error: Error)
    }

    struct Fetch {

    }
}
