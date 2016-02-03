// "import" macht Klassen ==> nachlesen! aus einem Paket zugänglich
import java.io.*;   // im Java.io Paket ist u.A. der "DataOutputStream" 
import java.net.*;  // im Java.net Paket ist u.A. der "Socket" 

// Variablendeklarationen
Socket clientSocket;          // Ein "Socket" (Engl. Steckdose) stellt die verbindung zu einem TCP/IP Server her.
DataOutputStream outToServer; // Der DataOutputStream erlaubt es uns, komplexe Daten wie Strings in den Socket zu schieben.
InputStream inFromServer;     // Der InputStream erlaubt es uns, Rohdaten vom Socket zu empfangen.

// bevor der Spaß beginnt, müssen wir eine Verbindung herstellen...
void setup() {
  // In Java können wir mit "try" etwas ausprobieren, was u.U schief läuft, ohne dass das Programm dann gleich abstürzt.
  // Das Ganze nennt sich "Exception Handling" und wird von vielen Java-Funktionen erzwungen, die einen guten Grund haben, fehlzuschlagen.
  // So könnte unserem Fall könnte z.B. der Zielhost nicht erreichbar sein - darauf sollten wir irgendwie vorbereitet sein.
  try {
    String serverAddress="192.168.0.75"; // die (IP) Adresse, mit der wir uns verbinden wollen
    int serverPort=8000;                 // der "Port", auf dem Server, mit dem wie reden wollen. (Muss gleich sein wie im Arduino-Programm)
    clientSocket = new Socket(serverAddress, serverPort); // Stelle eine Verbindung zum Server her.
    outToServer = new DataOutputStream(clientSocket.getOutputStream()); // Initialisiere die Klasse zum einfachen Datenversand
    inFromServer = clientSocket.getInputStream();                       // Initialisiere die Klasse zum Datenempfang
  }
  catch(Exception e) {
    println(e);    //falls etwas schief gelaufen ist, gebe die Fehlermeldung aus.
  }
}

// dieses Programm gibt einfach alles, was vom Server kommt, in der Konsole aus.
void draw() {
  try {
    //  outToServer.writeBytes(mouseX+"\t"+mouseY+"\n"); // sende die aktuelle Mausposition zum Arduino
    // gib alles aus, was an Daten vom Server kommt:
    while (inFromServer.available ()!=0) { // solange noch Daten da über sind....
      print((char)inFromServer.read()); // lese ein einzelnen Zeichen und gebe es in der Konsole aus.
    }
  } 
  catch(Exception e) {
    println(e);        //falls etwas schief gelaufen ist, gebe die Fehlermeldung aus.
  }
}
// Sende alles, was auf dem PC getippt wird, an den Server weiter.
void keyPressed() {
  try {
    outToServer.write(key); // nimm den Wert aus der Processing-Systemvariable "key" und schicke ihn an den Server
  }
  catch(Exception e) {
    println(e);        //falls etwas schief gelaufen ist, gebe die Fehlermeldung aus.
  }
}

