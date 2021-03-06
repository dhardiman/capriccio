//
//  SwiftTestCodeGeneratorTests+SenarioOutline.swift
//  CapriccioLibTests
//
//  Created by Franco on 04/09/2018.
//

import Foundation
import Nimble
import Gherkin
@testable import CapriccioLib

extension SwiftTestCodeGeneratorTests {
    func testItGeneratesTheCorrectCodeWithAnOutlineScenario() {
        let examples = [Example(values: ["key1": "value1", "key2": "value2"]),
                        Example(values: ["key1": "value3", "key2": "value4"])]
        
        let scenario: Scenario = .outline(ScenarioOutline(name: "Scenario I want to test",
                                                          description: "",
                                                          steps:[Step(name: .given, text: "I'm in a situation"),
                                                                 Step(name: .when, text: "Something happens <key1>"),
                                                                 Step(name: .then, text: "Something else happens <key2>")],
                                                          examples: examples))
        let feature = Feature(name: "Feature number one",
                              description: "",
                              scenarios: [scenario])
        
        let expectedResult = """
        import XCTest
        import XCTest_Gherkin

        final class FeatureNumberOne: XCTestCase {
                func testScenarioIWantToTestWithValue1AndValue2() {
                    Given("I'm in a situation")
                    When("Something happens value1")
                    Then("Something else happens value2")
        
                }
        
                func testScenarioIWantToTestWithValue3AndValue4() {
                    Given("I'm in a situation")
                    When("Something happens value3")
                    Then("Something else happens value4")
                }
        }
        """
        
        fileGenerationCheck(feature: feature, expectedResult: expectedResult)
    }
    
    func testItGeneratesTheCorrectCodeWithMultipleOutlineScenarios() {
        let examples = [Example(values: ["key1": "value1", "key2": "value2"]),
                        Example(values: ["key1": "value3", "key2": "value4"])]
        
        let scenario: Scenario = .outline(ScenarioOutline(name: "Scenario I want to test",
                                                          description: "",
                                                          steps:[Step(name: .given, text: "I'm in a situation"),
                                                                 Step(name: .when, text: "Something happens <key1>"),
                                                                 Step(name: .then, text: "Something else happens <key2>")],
                                                          examples: examples))
        
        let examples2 = [Example(values: ["key3": "value5", "key4": "value6"]),
                        Example(values: ["key3": "value7", "key4": "value8"])]
        
        let scenario2: Scenario = .outline(ScenarioOutline(name: "Other scenario I want to test",
                                                          description: "",
                                                          steps:[Step(name: .given, text: "I'm in another situation"),
                                                                 Step(name: .when, text: "Something different happens <key4>"),
                                                                 Step(name: .then, text: "Something else happens <key3>")],
                                                          examples: examples2))
        
        let feature = Feature(name: "Feature number one",
                              description: "",
                              scenarios: [scenario, scenario2])
        
        let expectedResult = """
        import XCTest
        import XCTest_Gherkin

        final class FeatureNumberOne: XCTestCase {
                func testScenarioIWantToTestWithValue1AndValue2() {
                    Given("I'm in a situation")
                    When("Something happens value1")
                    Then("Something else happens value2")
                }
        
                func testScenarioIWantToTestWithValue3AndValue4() {
                    Given("I'm in a situation")
                    When("Something happens value3")
                    Then("Something else happens value4")
                }

                func testOtherScenarioIWantToTestWithValue5AndValue6() {
                    Given("I'm in another situation")
                    When("Something different happens value6")
                    Then("Something else happens value5")
                }
        
                func testOtherScenarioIWantToTestWithValue7AndValue8() {
                    Given("I'm in another situation")
                    When("Something different happens value8")
                    Then("Something else happens value7")
                }
        }
        """
        
        fileGenerationCheck(feature: feature, expectedResult: expectedResult)
    }
    
    func testItGeneratesTheCorrectCodeWithAnOutlineScenarioAndComplexExamples() {
        let examples = [Example(values: ["key1": "value1", "key2": "text with spaces, commas and dots."]),
                        Example(values: ["key1": "another - really % complex @ text", "key2": "value4"])]
        
        let scenario: Scenario = .outline(ScenarioOutline(name: "Scenario I want to test",
                                                          description: "",
                                                          steps:[Step(name: .given, text: "I'm in a situation"),
                                                                 Step(name: .when, text: "Something happens <key1>"),
                                                                 Step(name: .then, text: "Something else happens <key2>")],
                                                          examples: examples))
        
        let feature = Feature(name: "Feature number one",
                              description: "",
                              scenarios: [scenario])
        
        let expectedResult = """
        import XCTest
        import XCTest_Gherkin

        final class FeatureNumberOne: XCTestCase {
                func testScenarioIWantToTestWithValue1AndTextWithSpacesCommasAndDots() {
                    Given("I'm in a situation")
                    When("Something happens value1")
                    Then("Something else happens text with spaces, commas and dots.")
                }
        
                func testScenarioIWantToTestWithAnotherReallyComplexTextAndValue4() {
                    Given("I'm in a situation")
                    When("Something happens another - really % complex @ text")
                    Then("Something else happens value4")
                }
        }
        """
        
        fileGenerationCheck(feature: feature, expectedResult: expectedResult)
    }
}
