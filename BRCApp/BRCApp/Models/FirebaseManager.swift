//
//  FirebaseManager.swift
//  BRCApp
//
//  Created by Vincent  Neumann on 11.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager{
    static let shared = FirebaseManager()
    

     var auth = Auth.auth()
     var fireStore = Firestore.firestore()
}
