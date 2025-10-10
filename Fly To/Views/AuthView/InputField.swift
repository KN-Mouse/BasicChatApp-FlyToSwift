//
//  InputField.swift
//  Fly To
//
//  Created by Nguyen Khang on 6/10/25.
//

import SwiftUI

struct InputField: View {
    
    enum fieldType {
        case normal
        case password
    }
    
    let placeholder: String
    let fill: fieldType
    @Binding var text: String
    @State var isSecure: Bool
    
    init(placeholder: String = "",
         text: Binding<String>,
         fill: fieldType = .normal
    ){
        self.placeholder = placeholder
        self._text = text
        self.fill = fill
        self._isSecure = State(initialValue: fill == .password)
    }
    
    var body: some View {
        HStack{
            if fill == .password && isSecure{
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
            }
            
            if fill == .password{
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                }
            }
        }
        .padding(12)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
    }
}

#Preview {
    InputField(placeholder: "Email", text: .constant(""), fill: .normal)
    InputField(placeholder: "Pass word", text: .constant(""), fill: .password)
}
