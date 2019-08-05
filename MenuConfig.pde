//===============File Menu===============
Menu menu_file = new Menu("File");
Menu menu_export = new Menu("Export");
Menu menu_new = new Menu("New");

MenuItem item_graph = new MenuItem("Graph");
MenuItem item_wgraph = new MenuItem("Weighted Graph");
MenuItem item_open = new MenuItem("Open");
MenuItem item_save = new MenuItem("Save");
MenuItem item_import = new MenuItem("Import");
MenuItem item_image = new MenuItem("Image");
MenuItem item_mtx = new MenuItem("MTX file");

//===============Edit Menu===============
Menu menu_edit = new Menu("Edit");
Menu menu_vertex = new Menu("Vertex");
Menu menu_edge = new Menu("Edge");
Menu menu_euclidean = new Menu("Apply euclidean weight");

MenuItem item_vcolor = new MenuItem("Color");
MenuItem item_vsize = new MenuItem("Size");
MenuItem item_vfont = new MenuItem("Id font");
MenuItem item_ecolor = new MenuItem("Color");
MenuItem item_efont = new MenuItem("Weight font");
MenuItem item_ethickness = new MenuItem("Thickness");
MenuItem item_erem = new MenuItem("Remove");
MenuItem item_existing = new MenuItem("to existing edges");
MenuItem item_complete = new MenuItem("to complete graph");
MenuItem item_range = new MenuItem("to vetices within range");  

//===============Algorithm Menu===============
Menu menu_algorithm = new Menu("Algorithm");

Menu menu_floodfill = new Menu("Floodfill");
Menu menu_mst = new Menu("MST");
Menu menu_sp = new Menu("SP");
Menu menu_dijkstra = new Menu("Dijkstra");

MenuItem item_dfs = new MenuItem("DFS");
MenuItem item_bfs = new MenuItem("BFS");
MenuItem item_kruskal = new MenuItem("Kruskal's");
MenuItem item_prim = new MenuItem("Prim's");
MenuItem item_cluster = new MenuItem("Cluster");
MenuItem item_single = new MenuItem("Single-source");
MenuItem item_multi = new MenuItem("Multiple-source");

//===============Animation Menu===============
Menu menu_animation = new Menu("Animation");

MenuItem item_speed = new MenuItem("Speed");
MenuItem item_render = new MenuItem("Render to image sequence");
MenuItem item_physics = new MenuItem("Run physics");
MenuItem item_physics2 = new MenuItem("Run physics2");

//===============Convert Menu===============
Menu menu_convert = new Menu("Convert");

MenuItem item_toPL = new MenuItem("to Graph");
MenuItem item_toWG = new MenuItem("to Weighted Graph");


void setupMenu() {
  MenuBar mbar = new MenuBar();

  //===============File Menu===============


  menu_new.add(item_graph);
  menu_new.add(item_wgraph);
  menu_export.add(item_image);
  menu_export.add(item_mtx);

  mbar.add(menu_file);

  menu_file.add(menu_new);
  menu_file.add(item_open);
  menu_file.add(item_save);
  menu_file.add(item_import);
  menu_file.add(menu_export);

  FileActionListener fal = new FileActionListener();

  item_graph.setActionCommand("graph");
  item_wgraph.setActionCommand("wgraph");
  item_open.setActionCommand("open");
  item_save.setActionCommand("save");
  item_import.setActionCommand("import");
  item_image.setActionCommand("image");
  item_mtx.setActionCommand("mtx");

  item_graph.addActionListener(fal);
  item_wgraph.addActionListener(fal);
  item_open.addActionListener(fal);
  item_save.addActionListener(fal);
  item_import.addActionListener(fal);
  item_image.addActionListener(fal);
  item_mtx.addActionListener(fal);

  //===============Edit Menu===============


  menu_vertex.add(item_vcolor);
  menu_vertex.add(item_vsize);
  menu_vertex.add(item_vfont);
  menu_edge.add(item_ecolor);
  menu_edge.add(item_ethickness);
  menu_edge.add(item_efont);
  menu_edge.add(item_erem);
  menu_euclidean.add(item_existing);
  menu_euclidean.add(item_complete);
  menu_euclidean.add(item_range);


  mbar.add(menu_edit);

  menu_edit.add(menu_vertex);
  menu_edit.add(menu_edge);
  menu_edit.add(menu_euclidean);


  EditActionListener eal = new EditActionListener();

  item_vcolor.setActionCommand("vcolor");
  item_vsize.setActionCommand("vsize");
  item_vfont.setActionCommand("vfont");
  item_ecolor.setActionCommand("ecolor");
  item_ethickness.setActionCommand("ethickness");
  item_existing.setActionCommand("existing");
  item_complete.setActionCommand("complete");
  item_efont.setActionCommand("efont");
  item_erem.setActionCommand("erem");
  item_range.setActionCommand("range");


  item_vcolor.addActionListener(eal);
  item_vsize.addActionListener(eal);
  item_vfont.addActionListener(eal);
  item_ecolor.addActionListener(eal);
  item_ethickness.addActionListener(eal);
  item_efont.addActionListener(eal);
  item_erem.addActionListener(eal);
  item_existing.addActionListener(eal);
  item_complete.addActionListener(eal);
  item_range.addActionListener(eal);

  //===============Algorithm Menu===============


  menu_floodfill.add(item_dfs);
  menu_floodfill.add(item_bfs);
  menu_mst.add(item_kruskal);
  menu_mst.add(item_prim);
  menu_mst.add(item_cluster);
  menu_dijkstra.add(item_single);
  menu_dijkstra.add(item_multi);
  menu_sp.add(menu_dijkstra);

  mbar.add(menu_algorithm);

  menu_floodfill.add(item_dfs);
  menu_floodfill.add(item_bfs);
  menu_mst.add(item_kruskal);
  menu_mst.add(item_prim);
  menu_mst.add(item_cluster);
  menu_sp.add(menu_dijkstra);

  menu_algorithm.add(menu_floodfill);
  menu_algorithm.add(menu_mst);
  menu_algorithm.add(menu_sp);

  AlgoActionListener aal = new AlgoActionListener();

  item_dfs.setActionCommand("dfs");
  item_bfs.setActionCommand("bfs");
  item_kruskal.setActionCommand("kruskal");
  item_prim.setActionCommand("prim");
  item_cluster.setActionCommand("cluster");
  item_single.setActionCommand("single");
  item_multi.setActionCommand("multi");

  item_dfs.addActionListener(aal);
  item_bfs.addActionListener(aal);
  item_kruskal.addActionListener(aal);
  item_prim.addActionListener(aal);
  item_cluster.addActionListener(aal);
  item_single.addActionListener(aal);
  item_multi.addActionListener(aal);


  //===============Animation Menu===============


  mbar.add(menu_animation);

  menu_animation.add(item_speed);
  menu_animation.add(item_render);
  menu_animation.add(item_physics);
  menu_animation.add(item_physics2);

  AnimationActionListener anime = new AnimationActionListener();

  item_speed.setActionCommand("speed");
  item_render.setActionCommand("render");
  item_physics.setActionCommand("physics");
  item_physics2.setActionCommand("physics2");

  item_speed.addActionListener(anime);
  item_render.addActionListener(anime);
  item_physics.addActionListener(anime);
  item_physics2.addActionListener(anime);

  //===============Convert Menu===============


  mbar.add(menu_convert);

  menu_convert.add(item_toPL);
  menu_convert.add(item_toWG);

  ConvertActionListener cal = new ConvertActionListener();

  item_toPL.setActionCommand("PL");
  item_toWG.setActionCommand("WG");

  item_toPL.addActionListener(cal);
  item_toWG.addActionListener(cal);


  PSurfaceAWT awtSurface = (PSurfaceAWT)surface;
  PSurfaceAWT.SmoothCanvas smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();
  smoothCanvas.getFrame().setMenuBar(mbar);
}

void setupPL(boolean b){
  item_efont.setEnabled(b);
  menu_euclidean.setEnabled(b);
  menu_mst.setEnabled(b);
  menu_sp.setEnabled(b);
  item_toPL.setEnabled(b);
}

void setupWG(boolean b){
  item_toWG.setEnabled(b);
}
