//
//  UserName.swift
//  VITTY
//
//  Created by Prashanna Rajbhandari on 20/05/2023.
//

import SwiftUI

struct UserName: View {
    @StateObject private var vm = UserNameViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authVM: AuthService

    var body: some View {
        ZStack {
            // background
            Color.theme.blueBG
                .ignoresSafeArea()

            // foreground
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image(systemName: vm.isFirstLogin ? "chevron.left" : "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .padding(.horizontal)
                
                headerText()
                textField(text: $vm.usernameTF, tfString: "Username", height: 75)

                textField(text: $vm.regNoTF, tfString: "Registration Number", height: 75)
                Spacer()
                continueButton()
            }
        }
    }
}

struct UserName_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                UserName()
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                UserName()
            }
        }
    }
}

// MARK: Extension

extension UserName {
    private func headerText() -> some View {
        VStack(alignment: .leading) {
            Text(vm.isFirstLogin ? "Let's Sign you in." : "Let’s add your \ndetails")
                .font(.custom("Poppins-Medium", size: 32))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text("Enter username and your registration number below. Your username will help your friends find you!")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color.theme.primary)
        }.padding(.leading)
    }

    private func continueButton() -> some View {
        Button {
            if vm.isRegistrationNumberValid() {
                if !vm.usernameTF.isEmpty && !vm.regNoTF.isEmpty {
                    print(authVM.loggedInUser?.uid ?? "no uid from username")

                    API.shared.signInUser(with: AuthReqBody(uuid: authVM.loggedInUser?.uid ?? "", reg_no: vm.regNoTF, username: vm.usernameTF)) { result in
                        switch result {
                        case let .success(response):

                            DispatchQueue.main.async {
                                authVM.myUser = response
                                
                                UserDefaults.standard.set(authVM.myUser.token, forKey: AuthService.tokenKey)
                                UserDefaults.standard.set(authVM.myUser.username, forKey: AuthService.userKey)
                                UserDefaults.standard.set(authVM.myUser.name, forKey: AuthService.nameKey)
                                UserDefaults.standard.set(authVM.myUser.picture, forKey: AuthService.imageKey)
                                
                                print("created new user")
                            }
                        case let .failure(error):
                            print("error while creating the user ", error.localizedDescription)
                        }
                    }

                    authVM.isNewUser = false
                }
            } else {
                vm.regNoTF = ""
            }
        } label: {
            Text("Continue")
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 65)
                .background(Color.theme.brightBlue)
                .cornerRadius(10)
                .padding()
        }
    }
}
