//
//  Student2.swift
//  DomainFun
//
//  Created by Mike AO on 10/9/24.
//

import Combine

final class Student2: ObservableObject {
  let id: String
  @Published var firstName: String
  @Published var lastName: String
  @Published private(set) var fullName: String = ""

  init(id: String, firstName: String, lastName: String) {
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    setup()
  }

  convenience init(dataObject: StudentDataObject) {
    self.init(
      id: dataObject.id,
      firstName: dataObject.firstName,
      lastName: dataObject.lastName
    )
  }

  func update(dataObject: StudentDataObject) {
    firstName = dataObject.firstName
    lastName = dataObject.lastName
  }

  func setup() {
    Publishers.CombineLatest($firstName, $lastName)
      .map { "\($0) \($1)" }
      .assign(to: &$fullName)
  }
}
