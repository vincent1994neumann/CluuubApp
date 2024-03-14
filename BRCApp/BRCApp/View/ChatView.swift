//
//  ChatView.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 13.03.24.
//

import SwiftUI

struct ChatView: View {
    @Binding var selectedTab: Tabs
    var body: some View {
        Text("ChatView")
    }
}

#Preview {
    ChatView(selectedTab: .constant(.chatView))
}
