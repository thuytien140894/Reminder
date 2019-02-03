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

protocol CollectionReferenceProtocol {
    func document(_ documentPath: String) -> DocumentReference
}

extension CollectionReference: CollectionReferenceProtocol {}

public protocol DocumentReferenceProtocol {
    func setData(_ documentData: [String: Any])
    func delete()
}

extension DocumentReference: DocumentReferenceProtocol {}

protocol QueryProtocol {
    func getDocuments(completion: @escaping FIRQuerySnapshotBlock)
}

extension Query: QueryProtocol {}
