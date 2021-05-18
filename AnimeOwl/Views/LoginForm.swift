//
//  LoginForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    @Binding var formShowing: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                    }
                }
                
                Button(action: {
                    signIn()
                }) {
                    HStack {
                        Spacer()
                        Text("Sign In")
                        Spacer()
                    }
                }
            }
            .background(Color.blue)
            .navigationBarTitle("Sign In")
            .navigationBarItems(trailing: Button(action: {
                formShowing = false
            }) {
                Image(systemName: "xmark")
            })
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    formShowing = false
                }
            }
        }
    }
    
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(formShowing: Binding.constant(true))
    }
}
