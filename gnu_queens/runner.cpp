/* Generated file, do not edit */

#ifndef CXXTEST_RUNNING
#define CXXTEST_RUNNING
#endif

#define _CXXTEST_HAVE_STD
#include <cxxtest/TestListener.h>
#include <cxxtest/TestTracker.h>
#include <cxxtest/TestRunner.h>
#include <cxxtest/RealDescriptions.h>
#include <cxxtest/ErrorPrinter.h>

int main() {
 return CxxTest::ErrorPrinter().run();
}
#include "board_tests.h"

static BoardTests suite_BoardTests;

static CxxTest::List Tests_BoardTests = { 0, 0 };
CxxTest::StaticSuiteDescription suiteDescription_BoardTests( "board_tests.h", 9, "BoardTests", suite_BoardTests, Tests_BoardTests );

static class TestDescription_BoardTests_test_create : public CxxTest::RealTestDescription {
public:
 TestDescription_BoardTests_test_create() : CxxTest::RealTestDescription( Tests_BoardTests, suiteDescription_BoardTests, 11, "test_create" ) {}
 void runTest() { suite_BoardTests.test_create(); }
} testDescription_BoardTests_test_create;

static class TestDescription_BoardTests_test_size : public CxxTest::RealTestDescription {
public:
 TestDescription_BoardTests_test_size() : CxxTest::RealTestDescription( Tests_BoardTests, suiteDescription_BoardTests, 18, "test_size" ) {}
 void runTest() { suite_BoardTests.test_size(); }
} testDescription_BoardTests_test_size;

static class TestDescription_BoardTests_test_place : public CxxTest::RealTestDescription {
public:
 TestDescription_BoardTests_test_place() : CxxTest::RealTestDescription( Tests_BoardTests, suiteDescription_BoardTests, 27, "test_place" ) {}
 void runTest() { suite_BoardTests.test_place(); }
} testDescription_BoardTests_test_place;

static class TestDescription_BoardTests_test_unplace : public CxxTest::RealTestDescription {
public:
 TestDescription_BoardTests_test_unplace() : CxxTest::RealTestDescription( Tests_BoardTests, suiteDescription_BoardTests, 43, "test_unplace" ) {}
 void runTest() { suite_BoardTests.test_unplace(); }
} testDescription_BoardTests_test_unplace;

static class TestDescription_BoardTests_test_is_ok : public CxxTest::RealTestDescription {
public:
 TestDescription_BoardTests_test_is_ok() : CxxTest::RealTestDescription( Tests_BoardTests, suiteDescription_BoardTests, 63, "test_is_ok" ) {}
 void runTest() { suite_BoardTests.test_is_ok(); }
} testDescription_BoardTests_test_is_ok;

static class TestDescription_BoardTests_test_solve_false : public CxxTest::RealTestDescription {
public:
 TestDescription_BoardTests_test_solve_false() : CxxTest::RealTestDescription( Tests_BoardTests, suiteDescription_BoardTests, 80, "test_solve_false" ) {}
 void runTest() { suite_BoardTests.test_solve_false(); }
} testDescription_BoardTests_test_solve_false;

static class TestDescription_BoardTests_test_solve_true : public CxxTest::RealTestDescription {
public:
 TestDescription_BoardTests_test_solve_true() : CxxTest::RealTestDescription( Tests_BoardTests, suiteDescription_BoardTests, 85, "test_solve_true" ) {}
 void runTest() { suite_BoardTests.test_solve_true(); }
} testDescription_BoardTests_test_solve_true;

#include <cxxtest/Root.cpp>
