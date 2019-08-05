
public class HeuristicUF {

  int[] p;
  int[] sz;

  public HeuristicUF(int n) {
    p = new int[n];
    sz = new int[n];
    for (int i = 0; i < n; i++) {
      p[i] = i;
      sz[i] = 1;
    }
  }

  private int root(int i) {
    return p[i] == i ? i : root(p[i]);
  }

  public void union(int u, int v) {
    if (sz[root(u)] <= sz[root(v)]) {
      p[root(u)] = root(v);
    } else {
      p[root(v)] = root(u);
    }
  }

  public boolean connected(int p, int q) {
    return root(p)==root(q);
  }
}
