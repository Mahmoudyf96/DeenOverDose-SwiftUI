//
//  SignUpView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-16.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isOBShowing: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func dismiss() {
        withAnimation {
            isOBShowing.toggle()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isOBShowing: Binding.constant(true))
    }
}
