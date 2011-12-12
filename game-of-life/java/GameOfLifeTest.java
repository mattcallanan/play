import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class GameOfLifeTest {

    @Test
    public void testProgress() {
        List<Point> world = new ArrayList<Point>();
        world.add(new Point(1, 1));
        world.add(new Point(2, 1));
        world.add(new Point(2, 2));
        List<Point> newWorld = GameOfLife.progress(world);
        assertEquals(expected(), newWorld);
    }

    @Test
    public void testLives() {
        List<Point> world = new ArrayList<Point>();

        world.add(new Point(1, 1));
        world.add(new Point(2, 1));
        world.add(new Point(2, 2));

        //test creation of cells
        assertEquals(true, GameOfLife.lives(new Point(1, 2), world));

        //orphaned cells die
        world.add(new Point(5, 5));
        assertEquals(false, GameOfLife.lives(new Point(5, 5), world));

        //2 neighbours live
        world.add(new Point(15, 15));
        world.add(new Point(14, 15));
        world.add(new Point(15, 16));
        assertEquals(true, GameOfLife.lives(new Point(15, 15), world));

        //>3 neighbours die
        world.add(new Point(25, 25));
        world.add(new Point(24, 25));
        world.add(new Point(25, 26));
        world.add(new Point(24, 26));
        world.add(new Point(26, 24));
        assertEquals(false, GameOfLife.lives(new Point(25, 25), world));

        world.add(new Point(24, 24));
        world.add(new Point(23, 23));
        world.add(new Point(23, 24));
        world.add(new Point(16, 15));

        for (int i = 0; i < 10; i++) {
            GameOfLife.print(world);
            List<Point> w2 = GameOfLife.progress(world);
            GameOfLife.print(w2);
            List<Point> w3 = GameOfLife.progress(w2);
            GameOfLife.print(w3);
            List<Point> w4 = GameOfLife.progress(w3);
            GameOfLife.print(w4);
            List<Point> w5 = GameOfLife.progress(w4);
            GameOfLife.print(w5);
        }

    }

    private List<Point> expected() {
        List<Point> world = new ArrayList<Point>();
        world.add(new Point(1, 1));
        world.add(new Point(1, 2));
        world.add(new Point(2, 1));
        world.add(new Point(2, 2));
        return world;

    }
}
