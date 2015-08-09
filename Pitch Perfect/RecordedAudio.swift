//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Brandon on 8/6/15.
//  Copyright (c) 2015 bc. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    init (filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}