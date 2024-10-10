//
//  StudentViewModel.swift
//  DomainFun
//
//  Created by Mike AO on 10/9/24.
//

import Observation

// View Model integration with an Observable domain object
@MainActor @Observable final class StudentViewModel {
  private(set) var studentFullName: String
  @ObservationIgnored let student: Student

  init(student: Student) {
    self.student = student
    self.studentFullName = student.fullName
    setupPipelines()
  }

  private func setupPipelines() {
    Task {
      for await fullName in student.fullNameChannel {
        studentFullName = fullName
      }
    }
  }
}
