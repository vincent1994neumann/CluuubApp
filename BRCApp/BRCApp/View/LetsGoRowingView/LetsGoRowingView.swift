//
//  LetsGoRowingView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct LetsGoRowingView: View {
    @Binding var selectedTab: Tabs
    var body: some View {
        Text("LetsGoRowingView!")
    }
}

#Preview {
    LetsGoRowingView(selectedTab: .constant(.letsGoRowingView))
}
