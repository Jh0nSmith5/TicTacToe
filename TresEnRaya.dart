import 'dart:io';

void main() {
  print('Bienvenido al juego de Tres en Raya!');
  String opcion = ' ';

  while (opcion != 'S') {
    List<List<String>> tablero = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9']
    ];

    String jugadorActual = 'X';
    bool juegoTerminado = false;

    while (!juegoTerminado) {
      // Mostrar tablero
      print('\n');
      for (var fila in tablero) {
        print(fila.join(' | '));
      }

      // Pedir jugada
      print('\nJugador $jugadorActual, elige una posición (1-9):');
      String? input = stdin.readLineSync();
      int? posicion = int.tryParse(input ?? '');

      // Validar entrada
      if (posicion == null || posicion < 1 || posicion > 9) {
        print('Posición inválida, intenta de nuevo.');
        continue;
      }

      // Colocar ficha en el tablero
      bool colocado = false;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (tablero[i][j] == posicion.toString()) {
            tablero[i][j] = jugadorActual;
            colocado = true;
          }
        }
      }

      if (!colocado) {
        print('Esa posición ya está ocupada, intenta de nuevo.');
        continue;
      }

      // Verificar ganador
      if (hayGanador(tablero, jugadorActual)) {
        for (var fila in tablero) {
          print(fila.join(' | '));
        }
        print('\n¡Jugador $jugadorActual gana!');
        juegoTerminado = true;
      } else if (tableroLleno(tablero)) {
        for (var fila in tablero) {
          print(fila.join(' | '));
        }
        print('\n¡Empate!');
        juegoTerminado = true;
      } else {
        // Cambiar turno
        jugadorActual = jugadorActual == 'X' ? 'O' : 'X';
      }
    }

    // Preguntar si quieren jugar de nuevo
    print('\n¿Quieres jugar de nuevo? (S para salir / cualquier tecla para continuar):');
    opcion = stdin.readLineSync()?.toUpperCase() ?? ' ';
  }

  print('¡Gracias por jugar!');
}

bool hayGanador(List<List<String>> board, String jugador) {
  // Filas
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == jugador && board[i][1] == jugador && board[i][2] == jugador) {
      return true;
    }
  }

  // Columnas
  for (int j = 0; j < 3; j++) {
    if (board[0][j] == jugador && board[1][j] == jugador && board[2][j] == jugador) {
      return true;
    }
  }

  // Diagonales
  if (board[0][0] == jugador && board[1][1] == jugador && board[2][2] == jugador) {
    return true;
  }
  if (board[0][2] == jugador && board[1][1] == jugador && board[2][0] == jugador) {
    return true;
  }

  return false;
}

bool tableroLleno(List<List<String>> board) {
  for (var fila in board) {
    for (var celda in fila) {
      if (celda != 'X' && celda != 'O') return false;
    }
  }
  return true;
}