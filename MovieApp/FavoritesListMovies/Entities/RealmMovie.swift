//
//  RealmMovie.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 24/4/23.
//

import Foundation
import Realm
import RealmSwift


class RealmMovie: Object{
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title               :String
    @Persisted var synopsis            :String
    @Persisted var imageURL            :String
    @Persisted var release             :String
    @Persisted var votes               :Int
    @Persisted var votesAverage        :Float
}
