void writeGraph(File selection) {
  if (selection==null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    graph.saveGraph(selection);
  }
}


void readGraph(File selection) {
  if (selection==null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    try {
      graph.openGraph(selection);
    }
    catch(IOException e) {
    }
  }
}


void writeImage(File selection) {
  if (selection==null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    save(selection.getAbsolutePath());
  }
}

void readMTX(File selection) {
  if (selection==null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    try {
      graph.importMTX(selection);
    }
    catch(IOException e) {
    }
  }
}

void writeMTX(File selection) {
  if (selection==null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    graph.exportMTX(selection);
  }
}
