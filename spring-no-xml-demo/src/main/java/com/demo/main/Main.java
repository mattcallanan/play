package com.demo.main;

public class Main {
    public static void main(String... args) {
        Class configCls = forName(args[0]);
        new DefaultLauncher().launch(configCls);
    }

    private static Class forName(String className) {
        try {
            return Class.forName(className);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
