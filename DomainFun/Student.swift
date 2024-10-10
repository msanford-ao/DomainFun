//
//  Student.swift
//  DomainFun
//
//  Created by Mike AO on 10/9/24.
//

import Observation
import AsyncAlgorithms

@Observable final class Student {
  let id: String

  var firstName: String {
    didSet(newValue) {
      Task { await firstNameChannel.send(newValue) }
    }
  }
  @ObservationIgnored let firstNameChannel = AsyncChannel<String>()

  var lastName: String {
    didSet(newValue) {
      Task { await lastNameChannel.send(newValue) }
    }
  }
  @ObservationIgnored let lastNameChannel = AsyncChannel<String>()

  var fullName: String = "" {
    didSet(newValue) {
      Task { await fullNameChannel.send(newValue) }
    }
  }
  @ObservationIgnored let fullNameChannel = AsyncChannel<String>()

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
    Task {
      for await (firstName, lastName) in combineLatest(firstNameChannel, lastNameChannel) {
        fullName = "\(firstName) \(lastName)"
      }
    }
  }
}
