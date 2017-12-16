// $Id: board_tests.h 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-25 

#include "board.h"
#include <cxxtest/TestSuite.h>

class BoardTests : public CxxTest::TestSuite {
public:
  void test_create(void) {
    Board b1(1);
    Board b4(4);
    Board b20(20);
    TS_ASSERT(true);
  }

  void test_size(void) {
    Board b1(1);
    TS_ASSERT_EQUALS(1, b1.size());
    Board b4(4);
    TS_ASSERT_EQUALS(4, b4.size());
    Board b20(20);
    TS_ASSERT_EQUALS(20, b20.size());
  }

  void test_place(void) {
    Board b(4);
    TS_ASSERT_EQUALS(-1, b.col(0));
    TS_ASSERT_EQUALS(-1, b.col(1));
    TS_ASSERT_EQUALS(-1, b.col(2));
    TS_ASSERT_EQUALS(-1, b.col(3));
    b.place(0, 1);
    b.place(1, 3);
    b.place(2, 0);
    b.place(3, 2);
    TS_ASSERT_EQUALS(1, b.col(0));
    TS_ASSERT_EQUALS(3, b.col(1));
    TS_ASSERT_EQUALS(0, b.col(2));
    TS_ASSERT_EQUALS(2, b.col(3));
  }

  void test_unplace(void) {
    Board b(4);
    b.place(0, 1);
    TS_ASSERT(!b.is_ok(1, 1));
    TS_ASSERT(!b.is_ok(0, 1));
    TS_ASSERT(!b.is_ok(2, 3));
    b.unplace(0);
    TS_ASSERT(b.is_ok(1, 1));
    TS_ASSERT(b.is_ok(0, 1));
    TS_ASSERT(b.is_ok(2, 3));

    b.place(1, 3);
    b.place(2, 0);
    b.place(3, 2);
    TS_ASSERT_EQUALS(3, b.unplace(1));
    TS_ASSERT_EQUALS(-1, b.col(1));
    TS_ASSERT_EQUALS(2, b.unplace(3));
    TS_ASSERT_EQUALS(-1, b.col(3));
  }

  void test_is_ok(void) {
    Board b(4);
    TS_ASSERT( b.is_ok(0, 0)); TS_ASSERT( b.is_ok(0, 1)); TS_ASSERT( b.is_ok(0, 2)); TS_ASSERT( b.is_ok(0, 3));
    TS_ASSERT( b.is_ok(1, 0)); TS_ASSERT( b.is_ok(1, 1)); TS_ASSERT( b.is_ok(1, 2)); TS_ASSERT( b.is_ok(1, 3));
    TS_ASSERT( b.is_ok(2, 0)); TS_ASSERT( b.is_ok(2, 1)); TS_ASSERT( b.is_ok(2, 2)); TS_ASSERT( b.is_ok(2, 3));
    TS_ASSERT( b.is_ok(3, 0)); TS_ASSERT( b.is_ok(3, 1)); TS_ASSERT( b.is_ok(3, 2)); TS_ASSERT( b.is_ok(3, 3));
    b.place(0, 1);
    TS_ASSERT(!b.is_ok(1, 0)); TS_ASSERT(!b.is_ok(1, 1)); TS_ASSERT(!b.is_ok(1, 2)); TS_ASSERT( b.is_ok(1, 3));
    TS_ASSERT( b.is_ok(2, 0)); TS_ASSERT(!b.is_ok(2, 1)); TS_ASSERT( b.is_ok(2, 2)); TS_ASSERT(!b.is_ok(2, 3));
    TS_ASSERT( b.is_ok(3, 0)); TS_ASSERT(!b.is_ok(3, 1)); TS_ASSERT( b.is_ok(3, 2)); TS_ASSERT( b.is_ok(3, 3));
    b.place(1, 3);
    TS_ASSERT( b.is_ok(2, 0)); TS_ASSERT(!b.is_ok(2, 1)); TS_ASSERT(!b.is_ok(2, 2)); TS_ASSERT(!b.is_ok(2, 3));
    TS_ASSERT( b.is_ok(3, 0)); TS_ASSERT(!b.is_ok(3, 1)); TS_ASSERT( b.is_ok(3, 2)); TS_ASSERT(!b.is_ok(3, 3));
    b.place(2, 0);
    TS_ASSERT(!b.is_ok(3, 0)); TS_ASSERT(!b.is_ok(3, 1)); TS_ASSERT( b.is_ok(3, 2)); TS_ASSERT(!b.is_ok(3, 3));
  }

  void test_solve_false(void) {
    Board b(3);
    TS_ASSERT(!b.solve());
  }

  void test_solve_true(void) {
    Board b(4);
    TS_ASSERT(b.solve());
    TS_ASSERT_EQUALS(1, b.col(0));
    TS_ASSERT_EQUALS(3, b.col(1));
    TS_ASSERT_EQUALS(0, b.col(2));
    TS_ASSERT_EQUALS(2, b.col(3));
  }

};

