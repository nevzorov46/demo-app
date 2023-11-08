//
//  DemoTests.swift
//  DemoTests
//
//  Created by Admin on 08.11.2023.
//

import XCTest

import Combine
@testable import Demo

final class DemoTests: XCTestCase {
    
    func awaitPublisher<T: Publisher>(
            _ publisher: T,
            timeout: TimeInterval = 5,
            file: StaticString = #file,
            line: UInt = #line
        ) throws -> T.Output {
            var result: Result<T.Output, Error>?
            let expectation = self.expectation(description: "Awaiting publisher")

            let cancellable = publisher.sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        result = .failure(error)
                    case .finished:
                        break
                    }

                    expectation.fulfill()
                },
                receiveValue: { value in
                    result = .success(value)
                }
            )

            waitForExpectations(timeout: timeout)
            cancellable.cancel()

            let unwrappedResult = try XCTUnwrap(
                result,
                "Awaited publisher did not produce any output",
                file: file,
                line: line
            )

            return try unwrappedResult.get()
        }
    
    func XCTAssertResult<T, E>(
        _ result: Result<T, E>,
        isSuccessWith value: T,
        message: (E) -> String = { "Expected to be a success but got a failure with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Error, T: Equatable {
        switch result {
        case .failure(let error):
            XCTFail(message(error), file: file, line: line)
        case .success(let resultValue):
            XCTAssertEqual(resultValue, value)
        }
    }

    func XCTAssertResult<T, E>(
        _ result: Result<T, E>,
        isFailureWith error: E,
        message: (T) -> String = { "Expected to be a failure but got a success with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Equatable & Error {
        switch result {
        case .failure(let resultError):
            XCTAssertEqual(resultError, error)
        case .success(let value):
            XCTFail(message(value), file: file, line: line)
        }
    }
    
    func XCTAssertResult<T, E>(
        _ result: Result<T, E>,
        isSuccessWith assertClosure: (T) -> Void,
        message: (E) -> String = { "Expected to be a success but got a failure with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Error {
        switch result {
        case .failure(let error):
            XCTFail(message(error), file: file, line: line)
        case .success(let resultValue):
            assertClosure(resultValue)
        }
    }
    

}
