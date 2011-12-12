import java.util.ArrayList;
import java.util.List;

public class GameOfLife {

    public static List<Point> progress(List<Point> world) {
        //foreach point in world
        //store smallest x point -1
        //store smallest y point -1
        //store largest x point + 1
        //store largest y point + 1
        //loop through all coords from smallest to largest
        //    check if lives or dies - if lives add to newWorld
        //return newWorld
        Point min = min(world);
        Point max = max(world);
        List<Point> newWorld = new ArrayList<Point>();
        for (int x = min.getX(); x < max.getX(); x++) {
            for (int y = min.getY(); y < max.getY(); y++) {
                Point point = new Point(x, y);
                if (lives(point, world)) newWorld.add(point);
            }
        }
        return newWorld;
    }

    public static boolean lives(Point point, List<Point> world) {
        int n = aliveNeighbours(point, world);
        boolean alreadyAlive = world.contains(point);
        //see if it lives on
        if (alreadyAlive) return (n == 2 || n == 3);
        return n == 3;
    }

    private static int aliveNeighbours(Point point, List<Point> world) {
        int aliveNeighbours = 0;
        for (int y = -1; y <= 1; y++) {
            for (int x = -1; x <= 1; x++) {
                if (x == 0 && y == 0)
                    continue;
                int testX = point.getX() + x;
                int testY = point.getY() + y;
                if (world.contains(new Point(testX, testY))) {
                    aliveNeighbours++;
                }
            }
        }
        return aliveNeighbours;
    }

    private static Point min(List<Point> world) {
        int minX = 0, minY = 0;
        for (Point point : world) {
            if (point.getX() < minX) minX = point.getX();
            if (point.getY() < minY) minY = point.getY();
        }
        return new Point(minX - 1, minY - 1);
    }

    private static Point max(List<Point> world) {
        int maxX = 0, maxY = 0;
        for (Point point : world) {
            if (point.getX() > maxX) maxX = point.getX();
            if (point.getY() > maxY) maxY = point.getY();
        }
        return new Point(maxX + 1, maxY + 1);
    }

    public static void print(List<Point> world) {
        System.out.println("***********************************************");
        System.out.println("world = " + world);
        Point min = min(world);
        Point max = max(world);
        for (int y = min.getY(); y < max.getY(); y++) {
            for (int x = min.getX(); x < max.getX(); x++) {
                Point point = new Point(x, y);
                System.out.print(world.contains(point) ? "*" : ".");
            }
            System.out.println("");
        }

    }
}
