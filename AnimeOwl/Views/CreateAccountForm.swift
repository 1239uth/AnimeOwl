//
//  CreateAccountForm.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-18.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountForm: View {
    @Binding var loggedIn: Bool
    
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            Color.white
            LinearGradient(gradient: Gradient(colors: [Color("button").opacity(0.8), Color("background").opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Spacer()
                OwlLogo()
                    .padding(.bottom, 50)
                // MARK: - Account info
                VStack (alignment: .leading) {
                    Text("Sign Up")
                        .font(Font.custom("Avenir", size: 25))
                        .padding(.leading, 8)
                    TextField("Email", text: $email)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                    TextField("Name", text: $name)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                    SecureField("Password", text: $password)
                        .padding(12)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                // MARK: - Error Message
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 70)
                    
                    // MARK: - Error Message
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Sign In Button
                Button(action: {
                    createAccount()
                }) {
                    HomeButton(text: "Create Account")
                }
                Spacer()
            }
            .padding(.top, 50)
        }
        .onAppear {
            // Reset info
            email = ""
            name = ""
            password = ""
            errorMessage = ""
        }
        .ignoresSafeArea()
        
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    loggedIn = true
                }
            }
        }
    }
    
}

struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountForm(loggedIn: Binding.constant(true))
    }
}
