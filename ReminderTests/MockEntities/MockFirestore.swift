//
//  MockFirestore.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/17/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import FirebaseFirestore
@testable import Reminder

class MockFirestore: FirestoreProtocol {
    
    var settings = FirestoreSettings()
    private var collections: [MockCollectionReference] = []
    
    func collection(_ collectionPath: String) -> CollectionReference {
        
        if let existingCollection = collections.first(where: { $0.identifier == collectionPath }) {
            return existingCollection
        }
        
        let collection = MockCollectionReference(identifier: collectionPath)
        collections.append(collection)
        return collection
    }
}

class MockCollectionReference: CollectionReference {
    
    let identifier: String
    private var documents: [MockDocumentReference] = []
    
    init(identifier: String) {
        
        self.identifier = identifier
    }
    
    override func document(_ documentPath: String) -> DocumentReference {
    
        if let existingDocument = documents.first(where: { $0.identifier == documentPath }) {
            return existingDocument
        }
    
        let document = MockDocumentReference(parent: self, identifier: documentPath)
        documents.append(document)
        return document
    }
    
    override func document() -> DocumentReference {
        
        let uuid = UUID().uuidString
        let document = MockDocumentReference(parent: self, identifier: uuid)
        documents.append(document)
        return document
    }
    
    override func getDocuments(completion: @escaping FIRQuerySnapshotBlock) {
        
        let querySnapshot = MockQuerySnapshot(documents: documents)
        completion(querySnapshot, nil)
    }
    
    func deleteDocument(_ documentReference: MockDocumentReference) {
        
        documents = documents.filter { $0 != documentReference }
    }
}

class MockDocumentReference: DocumentReference {
    
    var data: [String: Any] = [:]
    let identifier: String
    override var parent: CollectionReference {
        return mockParent
    }
    override var documentID: String {
        return identifier
    }
    private var collections: [MockCollectionReference] = []
    private let mockParent: MockCollectionReference
    
    init(parent: MockCollectionReference, identifier: String) {
        
        mockParent = parent
        self.identifier = identifier
    }
    
    override func setData(_ documentData: [String: Any]) {
        
        data = documentData
    }
    
    override func delete() {
        
        mockParent.deleteDocument(self)
    }
    
    override func collection(_ collectionPath: String) -> CollectionReference {
        
        if let existingCollection = collections.first(where: { $0.identifier == collectionPath }) {
            return existingCollection
        }
        
        let collection = MockCollectionReference(identifier: collectionPath)
        collections.append(collection)
        return collection
    }
}

class MockQuerySnapshot: QuerySnapshot {
    
    override var documents: [QueryDocumentSnapshot] {
        return documentSnapshots
    }
    private let documentSnapshots: [MockQueryDocumentSnapshot]
    
    init(documents: [MockDocumentReference]) {
        
        documentSnapshots = documents.map { MockQueryDocumentSnapshot(document: $0) }
    }
}

class MockQueryDocumentSnapshot: QueryDocumentSnapshot {
    
    override var reference: DocumentReference {
        return document
    }
    override var documentID: String {
        return reference.documentID
    }
    private let document: MockDocumentReference
    
    init(document: MockDocumentReference) {
        
        self.document = document
    }
    
    override func data() -> [String: Any] {
        
        return document.data
    }
}
