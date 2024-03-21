//
//  RequestView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 21.03.24.
//

import SwiftUI

struct RequestView: View {
    var request: LetsGoRowingRequest
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(request.boatType.rawValue)
            Text(request.rowingStyle.rawValue)
            Text("Skill Level: \(request.skillLevel.rawValue)")
            // Weitere Details hier
        }
    }
}


