// $Id: BoardTest.groovy 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-27 

class BoardTest extends GroovyTestCase {

  void testCreate() {
    def b1 = new Board(1)
    def b2 = new Board(2)
    def b20 = new Board(20)
    assertTrue(true)
  }

  void testSize() {
    def b1 = new Board(1)
    assertEquals(1, b1.size)
    def b4 = new Board(4)
    assertEquals(4, b4.size)
    def b20 = new Board(20)
    assertEquals(20, b20.size)
  }

  void testPlace() {
    def b = new Board(4);
    assertEquals(-1, b.getCol(0))
    assertEquals(-1, b.getCol(1))
    assertEquals(-1, b.getCol(2))
    assertEquals(-1, b.getCol(3))
    b.place(0, 1)
    b.place(1, 3)
    b.place(2, 0)
    b.place(3, 2)
    assertEquals(1, b.getCol(0))
    assertEquals(3, b.getCol(1))
    assertEquals(0, b.getCol(2))
    assertEquals(2, b.getCol(3))
  }

  void testUnplace() {
    def b = new Board(4)
    b.place(0, 1)
    assertFalse(b.isOk(1, 1))
    assertFalse(b.isOk(0, 1))
    assertFalse(b.isOk(2, 3))
    b.unplace(0)
    assertTrue(b.isOk(1, 1))
    assertTrue(b.isOk(0, 1))
    assertTrue(b.isOk(2, 3))
    b.place(1, 3)
    b.place(2, 0)
    b.place(3, 2)
    assertEquals(3, b.unplace(1))
    assertEquals(-1, b.getCol(1))
    assertEquals(2, b.unplace(3))
    assertEquals(-1, b.getCol(3))
  }

  void testIsOk() {
    def b = new Board(4)
    assertTrue( b.isOk(0, 0)); assertTrue( b.isOk(0, 1)); assertTrue( b.isOk(0, 2)); assertTrue( b.isOk(0, 3));
    assertTrue( b.isOk(1, 0)); assertTrue( b.isOk(1, 1)); assertTrue( b.isOk(1, 2)); assertTrue( b.isOk(1, 3));
    assertTrue( b.isOk(2, 0)); assertTrue( b.isOk(2, 1)); assertTrue( b.isOk(2, 2)); assertTrue( b.isOk(2, 3));
    assertTrue( b.isOk(3, 0)); assertTrue( b.isOk(3, 1)); assertTrue( b.isOk(3, 2)); assertTrue( b.isOk(3, 3));
    b.place(0, 1)
    assertTrue(!b.isOk(1, 0)); assertTrue(!b.isOk(1, 1)); assertTrue(!b.isOk(1, 2)); assertTrue( b.isOk(1, 3));
    assertTrue( b.isOk(2, 0)); assertTrue(!b.isOk(2, 1)); assertTrue( b.isOk(2, 2)); assertTrue(!b.isOk(2, 3));
    assertTrue( b.isOk(3, 0)); assertTrue(!b.isOk(3, 1)); assertTrue( b.isOk(3, 2)); assertTrue( b.isOk(3, 3));
    b.place(1, 3)
    assertTrue( b.isOk(2, 0)); assertTrue(!b.isOk(2, 1)); assertTrue(!b.isOk(2, 2)); assertTrue(!b.isOk(2, 3));
    assertTrue( b.isOk(3, 0)); assertTrue(!b.isOk(3, 1)); assertTrue( b.isOk(3, 2)); assertTrue(!b.isOk(3, 3));
    b.place(2, 0)
    assertTrue(!b.isOk(3, 0)); assertTrue(!b.isOk(3, 1)); assertTrue( b.isOk(3, 2)); assertTrue(!b.isOk(3, 3));
  }

  void testSolveFalse() {
    def b = new Board(3)
    assertFalse(b.solve())
  }

  void testSolveTrue() {
    def b = new Board(4)
    assertTrue(b.solve())
    assertEquals(1, b.getCol(0))
    assertEquals(3, b.getCol(1))
    assertEquals(0, b.getCol(2))
    assertEquals(2, b.getCol(3))
  }

}

