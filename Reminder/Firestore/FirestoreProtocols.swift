//
//  FirestoreProtocols.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/17/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import FirebaseFirestore

protocol FirestoreProtocol: class {
    var settings: FirestoreSettings { get set }
    func collection(_ collectionPath: String) -> CollectionReference
}

extension Firestore: FirestoreProtocol {}
