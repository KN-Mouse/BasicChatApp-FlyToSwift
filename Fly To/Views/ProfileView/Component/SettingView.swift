//
//  SettingView.swift
//  Fly To
//
//  Created by Nguyen Khang on 18/10/25.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button{
            Task {
                await authVM.SignOut()
                dismiss()
            }
        } label: {
            Text("Sign Out")
        }
    }
}

#Preview {
    SettingView()
        .environmentObject(AuthViewModel())
}
