//
//  LoginFromDBCheck.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 24.01.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


protocol UserdataValidator{
    func userLogIn(email: String, password: String, completion: @escaping (_ requestResult: String?) -> ())
}
protocol UserdataSaver {
    func createUser(newUser: Userdata, completion: @escaping (_ requestResult: String?) -> ())
}

class FirebaseUserdata: UserdataValidator, UserdataSaver {
    
    func userLogIn(email: String, password: String, completion: @escaping (_ requestResult: String?) -> ()) {
        var requestResult: String?
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                requestResult = error!.localizedDescription
            }
            if let result = result {
                self.readUserData(userId: result.user.uid)
                completion(requestResult)
            }
        }
    }
    
    func createUser(newUser: Userdata, completion: @escaping (_ requestResult: String?) -> ()) {
        var requestResult: String?
        Auth.auth().createUser(withEmail: newUser.username, password: newUser.password) { (result, error) in
            if error != nil {
                requestResult = error!.localizedDescription
            } else {
                guard let authDataResult = result else {return}
                requestResult = self.saveUserdata(newUserData: newUser, createUserResult: authDataResult)
                completion(requestResult)
            }
        }
    }
    
    private func saveUserdata(newUserData: Userdata, createUserResult: AuthDataResult) -> String? {
        var saveUserdataResult: String?
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["firstname":newUserData.firstName, "lastname": newUserData.lastName, "uid": createUserResult.user.uid]) { (error) in
            if error != nil {
                saveUserdataResult = "Can't store userdata"
            }
        }
        return saveUserdataResult
    }
    
    private func readUserData (userId: String) {
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let resultData = document.data()
                        userdata.firstName = resultData["firstname"] as! String
                        userdata.lastName = resultData["lastname"] as! String
                    }
                }
        }
    }
}
