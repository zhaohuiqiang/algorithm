package cn.cstn.algorithm.corporation.bytedance;

import java.util.Scanner;

public class Xor {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(), m = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++)
            arr[i] = sc.nextInt();

        System.out.println(xor(arr, m));
        System.out.println(_xor(arr, m));
    }

    private static int _xor(int[] arr, int m) {
        int count = 0, i = 31;
        TrieNode root = buildTrieTree(arr);
        System.out.println("root.count: " + root.count);
        for (int a : arr)
            count += findGreaterThanM(root, a, m, i);

        return count / 2;
    }

    private static int findGreaterThanM(TrieNode root, int a, int m, int i) {
        if (root == null) return 0;

        TrieNode cur = root;
        for (int j = i; j >= 0; j--) {
            int dij = (a >> j) & 1;
            int mj = (m >> j) & 1;
            if (dij == 1 && mj == 1) {
                if (cur.children[0] == null) return 0;
                cur = cur.children[0];
            } else if (dij == 1 && mj == 0) {
                int p = cur.children[0] == null ? 0 : cur.children[0].count;
                return p + findGreaterThanM(cur.children[1], a, m, i - 1);
            } else if (dij == 0 && mj == 1) {
                if (cur.children[1] == null) return 0;
                cur = cur.children[1];
            } else if (dij == 0 && mj == 0) {
                int q = cur.children[1] == null ? 0 : cur.children[1].count;
                return findGreaterThanM(cur.children[0], a, m, i - 1) + q;
            }
        }
        return 0;
    }

    private static TrieNode buildTrieTree(int[] arr) {
        TrieNode root = new TrieNode();
        for (int a : arr) {
            TrieNode cur = root;
            for (int j = 31; j >= 0; j--) {
                int dij = (a >> j) & 1;
                if (cur.children[dij] == null) cur.children[dij] = new TrieNode();
                cur.children[dij].count++;
                cur = cur.children[dij];
            }
        }

        TrieNode p = root.children[0], q = root.children[1];
        if (p != null && q != null)
            root.count = p.count + q.count;
        else if (p != null)
            root.count = p.count;
        else if (q != null)
            root.count = q.count;

        return root;
    }

    static class TrieNode {
        TrieNode[] children = new TrieNode[2];
        int count = 0;
    }

    private static int xor(int[] arr, int m) {
        int count = 0, n = arr.length;
        for (int i = 0; i < n - 1; i++)
            for (int j = i + 1; j < n; j++)
                if ((arr[i] ^ arr[j]) > m) count++;
        return count;
    }

}
