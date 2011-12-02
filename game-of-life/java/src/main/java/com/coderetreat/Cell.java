package com.coderetreat;

import java.util.List;

public class Cell {
    private int x;
    private int y;
    private boolean alive;

    public Cell(int x, int y, boolean alive) {
        this.x = x;
        this.y = y;
        this.alive = alive;
    }

    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public boolean isAlive() {
        return alive;
    }

    public void setAlive(boolean alive) {
        this.alive = alive;
    }

    public boolean lives(List<Cell> neighbours) {
        int liveNeighbours = 0;
        for (Cell neighbour : neighbours) if (neighbour.isAlive()) liveNeighbours++;
        if (isAlive() && underPopulated(liveNeighbours)) return false;
        if (isAlive() && overPopulated(liveNeighbours)) return false;
        if (!isAlive() && reproduce(liveNeighbours)) return true;
        return isAlive();
    }

    @Override
    public String toString() {
        return "Cell{" +
                "x=" + x +
                ", y=" + y +
                ", alive=" + alive +
                '}';
    }

    private boolean underPopulated(int liveNeighbours) {
        return liveNeighbours < 2;
    }

    private boolean overPopulated(int liveNeighbours) {
        return liveNeighbours > 3;
    }

    private boolean reproduce(int liveNeighbours) {
        return liveNeighbours == 3;
    }
}
