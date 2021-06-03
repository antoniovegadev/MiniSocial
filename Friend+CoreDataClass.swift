//
//  Friend+CoreDataClass.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/31/21.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    enum DecoderConfiguationError: Error {
        case missingObjectContext
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext else {
            throw DecoderConfiguationError.missingObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
