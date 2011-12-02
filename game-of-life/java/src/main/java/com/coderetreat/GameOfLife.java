package com.coderetreat;

import java.util.ArrayList;
import java.util.List;

public class GameOfLife {

    public static Universe next(Universe universe) {
        List<Cell> cells = new ArrayList<Cell>();
        for (Cell cell : universe.getCells()) {
            int x = cell.getX();
            int y = cell.getY();
            cells.add(new Cell(x, y, cell.lives(universe.getNeighbours(x, y))));
        }
        return new Universe(cells);
    }

    public static Universe print(Universe universe) {
        int previousRow = 0;
        for (Cell cell : universe.getCells()) {
            if (cell.getY() != previousRow) {
                System.out.println("");
                previousRow = cell.getY();
            }
            System.out.print(cell.isAlive() ? "*" : ".");
        }
        return universe;
    }

    static Universe printAndNext(Universe universe) {
        print(universe);
        System.out.println("\n*************************");
        return next(universe);
    }
}
