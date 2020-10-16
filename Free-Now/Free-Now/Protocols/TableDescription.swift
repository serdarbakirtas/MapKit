//
//  TableDescription.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation

struct TableDescription {
    var sections: [String]
    var table: String
    
    init(tableDescription: String, sectionsDescriptions: [String]) {
        self.table = tableDescription
        self.sections = sectionsDescriptions
    }
    
    init(singleDescription: String) {
        self.table = singleDescription
        self.sections = [singleDescription]
    }
}
