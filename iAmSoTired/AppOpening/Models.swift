import RealmSwift
import Foundation

enum Priority: String, CaseIterable, PersistableEnum {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

class Note: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title = ""
    @Persisted var isComplete = false
    @Persisted var owner_id: String
    @Persisted var notes: List<SubNote> = List<SubNote>()
    @Persisted var priority = Priority.medium
    @Persisted var date: Date = Date.now
}

class SubNote: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var text = ""
    @Persisted var owner_id: String
}
