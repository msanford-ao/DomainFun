//
//  StudentViewModel2.swift
//  DomainFun
//
//  Created by Mike AO on 10/9/24.
//

import Observation
import Combine


// View Model integration with a Combine domain object
@MainActor @Observable final class StudentViewModel2 {
  let student: Student2
  var studentFullName: String
  private var cancellables: Set<AnyCancellable> = []

  init(student: Student2) {
    self.student = student
    self.studentFullName = student.fullName
    setupPipelines()
  }

  private func setupPipelines() {
    student.$fullName
      .sink { [unowned self] in studentFullName = $0 }
      .store(in: &cancellables)
  }
}

/*
@Observable final class StudentViewModel3 {
  let student: Student2
  @Republish(student, key: \.fullName) var studentFullName

  init(student: Student2) {
    self.student = student
  }
}
*/
