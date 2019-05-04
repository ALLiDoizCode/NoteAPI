import Vapor
import MeowVapor

class NoteController {
    var router:Router?
    var jsonEncoder = JSONEncoder()
    init(router:Router) {
        self.router = router
        let noteRoute = router.grouped("note")
        noteRoute.get("",String.parameter,use: getNote)
        noteRoute.get("fetch",use: fetch)
        noteRoute.put("save",use: save)
    }

    func save(req: Request) throws -> Future<Note> {
        let note = try req.content.decode(Note.self)
        return note.flatMap { object in
            if object._id == "" {
                object._id = UUID().uuidString
                return req.meow().map { context in
                    object.save(to: context)
                    return object
                }
            }else {
                return req.meow().map { context in
                    object.save(to: context)
                    return object
                }
            }
            
        }
    }

    func getNote(req: Request) throws -> Future<[Note]> {
        let title = try req.parameters.next(String.self)
        return req.meow().flatMap { context in
            return context.find(Note.self, where: ["title":title]).getAllResults().map({ notes in
                return notes
            })
        }
    }

    func fetch(req: Request) throws -> Future<[Note]> {
        return req.meow().flatMap({ context in
            let notes = context.find(Note.self)
            return notes.getAllResults().map({ objects in
                return objects
            })
        })
    }
}