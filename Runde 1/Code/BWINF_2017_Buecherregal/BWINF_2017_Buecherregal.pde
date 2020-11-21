int Zahl_Textdatei = 1;
String Anfang_Textdatei = "buecherregal";
int Anzahl_Deko_Figuren;
int Anzahl_Buecher;
IntList Hoehe_Buecher = new IntList();
IntList Hoehe_Buecher_sortiert = new IntList();

ArrayList<IntList> Abschnitt = new ArrayList<IntList>();

void setup() {
  ladeTextdokument(Anfang_Textdatei+Zahl_Textdatei+".txt", true);
  for (int i = 0; i< Anzahl_Deko_Figuren+1; i++) {
    Abschnitt.add(new IntList());
  }
  sortiere_Buecher(true);
  ordneZu();
  pruefeObMoeglich();
}
void draw() {
}

void ladeTextdokument(String dateiname, boolean output) {
  if (output) {
    println("Lese Daten aus Textdatei" + dateiname);
    println();
  }
  Anzahl_Deko_Figuren = Integer.parseInt(loadStrings(dateiname)[0]);
  if (output) {
    println("Anzahl Deko-Figuren = " + Anzahl_Deko_Figuren);
  }

  Anzahl_Buecher = Integer.parseInt(loadStrings(dateiname)[1]);
  if (output) {
    println("Anzahl Bücher = " + Anzahl_Buecher);
    print("Höhe Bücher : ");
  }
  for (int i = 0; i < Anzahl_Buecher; i++) {
    Hoehe_Buecher.append(Integer.parseInt(loadStrings(dateiname)[i+2]));
    if (output) {
      print(Hoehe_Buecher.get(i)+" , ");
    }
  }
  if (output) {
    println();
  }
}

void sortiere_Buecher(boolean output) {
  println("Sortiere Daten");
  println();
  Hoehe_Buecher_sortiert = Hoehe_Buecher;
  Hoehe_Buecher_sortiert.sort();
  if (output) {
    print("Höhe Bücher sortiert : ");
    for (int i = 0; i < Hoehe_Buecher_sortiert.size(); i++) {
      print(Hoehe_Buecher_sortiert.get(i)+" , ");
    }
    println();
  }
}
void ordneZu() {
  println("teile Daten in Abschnitte ein");
  println();
  int counter = 0;

  for (int i = 0; i<Anzahl_Deko_Figuren+1; i++) {
    while ((counter < Hoehe_Buecher_sortiert.size()) && pruefeHoehenunterschied(i, counter)) {
      Abschnitt.get(i).append(Hoehe_Buecher_sortiert.get(counter));
      counter ++;
    }
    println("Abschitt "+(i+1)+" : "+Abschnitt.get(i));
  }
}

boolean pruefeHoehenunterschied(int i, int counter) {
  if (Abschnitt.get(i).size() > 0) {
      return Hoehe_Buecher_sortiert.get(counter) - Abschnitt.get(i).min() < 30;
  } else {
    return true;
  }
}
void pruefeObMoeglich() {
  int summe = 0;
  for (int i = 0; i<Anzahl_Deko_Figuren+1; i++) {
    summe += Abschnitt.get(i).size();
  }
  if (summe < Anzahl_Buecher) {
    println("Nicht möglich");
  } else {
    println("möglich");
  }
}