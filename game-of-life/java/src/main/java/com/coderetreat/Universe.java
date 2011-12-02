package com.coderetreat;

import java.util.ArrayList;
import java.util.List;

public class Universe {
    private List<Cell> cells = new ArrayList<Cell>();
    private int maxX;
    private int maxY;

    public Universe(String... rows) {
        cells = rowsToCells(rows);
        maxX = rows[0].length()-1;
        maxY = rows.length-1;
        System.out.println("maxX = " + maxX);
        System.out.println("maxY = " + maxY);
    }

    public Universe(List<Cell> cells) {
        this.cells = cells;
        maxX = deriveMaxX(cells);
        maxY = deriveMaxY(cells);
    }

    private int deriveMaxX(List<Cell> cells) {
        int max = 0;
        for (Cell cell : cells) if (cell.getX() > max) max = cell.getX();
        return max;
    }

    private int deriveMaxY(List<Cell> cells) {
        int max = 0;
        for (Cell cell : cells) if (cell.getY() > max) max = cell.getY();
        return max;
    }

    public List<Cell> getCells() {
        return cells;
    }

    public List<Cell> getNeighbours(int x, int y) {
        List<Cell> result = new ArrayList<Cell>();
        if (x == 0 || x == maxX) {
        }
        if (y == 0 || y == maxY) {
        }
        result.add(north(x, y));
        result.add(northeast(x, y));
        result.add(east(x, y));
        result.add(southeast(x, y));
        result.add(south(x, y));
        result.add(southwest(x, y));
        result.add(west(x, y));
        result.add(northwest(x, y));
        return result;
    }

    private Cell north(int x, int y) {
        return get(x, y - 1);
    }

    private Cell northeast(int x, int y) {
        return get(x + 1, y - 1);
    }

    private Cell east(int x, int y) {
        return get(x + 1, y);
    }

    private Cell southeast(int x, int y) {
        return get(x + 1, y + 1);
    }

    private Cell south(int x, int y) {
        return get(x, y + 1);
    }

    private Cell southwest(int x, int y) {
        return get(x - 1, y + 1);
    }

    private Cell west(int x, int y) {
        return get(x - 1, y);
    }

    private Cell northwest(int x, int y) {
        return get(x - 1, y - 1);
    }

    private Cell get(int x, int y) {
//        System.out.println("(x:" + x + ", y:" + y + ") wrapped to (x:" + wrapX(x) + ", y:" + wrapY(y) + ")");
        x = wrapX(x);
        y = wrapY(y);
        for (Cell cell : cells) {
//            System.out.println("Checking cell: " + cell);
            if (cell.getX() == x && cell.getY() == y) return cell;
        }
        throw new IllegalArgumentException("Cell at (x:" + x + ", y:" + y + ") doesn't exist.");
    }

    private int wrapX(int x) {
//        return ((x + 2) % maxX) - 1;
        if (x < 0) return maxX;
        if (x > maxX) return 0;
        return x;
    }

    private int wrapY(int y) {
//        return ((y + 2) % maxY) - 1;
        if (y < 0) return maxY;
        if (y > maxY) return 0;
        return y;
    }

    private List<Cell> rowsToCells(String[] rows) {
        List<Cell> cells = new ArrayList<Cell>();
        for (int y = 0; y < rows.length; y++) {
            for (int x = 0; x < rows[0].length(); x++) {
                cells.add(new Cell(x, y, rows[y].charAt(x) == '*'));
            }
        }
        return cells;
    }

//    public String[] getRows() {
//        return rows;
//    }
//
//    public String getCell(int x, int y) {
//        if (y > rows.length) throw new IllegalArgumentException("Row " + x + " is out of bounds.");
//        if (x > rows[0].length()) throw new IllegalArgumentException("Column " + x + " is out of bounds.");
//        return "" + rows[y].charAt(x);
//    }
//
//    public int minX() {return 0;}
//    public int minY() {return 0;}
//    public int maxX() {return rows[0].length();}
//    public int maxY() {return rows.length;}

    public String nextGen(int x, int y) {
        throw new UnsupportedOperationException();
    }

//    public void addCell(Cell cell) {
//        cells.add(cell);
//    }
}
