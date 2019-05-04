import Vapor
import MeowVapor

final class Note:Content,Model {
    var _id:String
    var title:String
    var text:String
}