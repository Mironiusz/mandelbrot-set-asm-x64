
# Mandelbrot Visualisation

### Autor: Rafał Mironko

---

## Opis projektu

**Mandelbrot Visualization** to program napisany w assemblerze, który generuje i wizualizuje zbiór Mandelbrota. Wykorzystując bibliotekę Allegro, program umożliwia przybliżanie i przesuwanie po zbiorze Mandelbrota w czasie rzeczywistym, oferując użytkownikowi interaktywne doświadczenie eksploracji tego fraktala.

## Funkcje

- **Generowanie Zbioru Mandelbrota**: Program oblicza i wyświetla fraktal Mandelbrota.
- **Interaktywna Wizualizacja**: Użytkownicy mogą przybliżać i przesuwać po zbiorze Mandelbrota w czasie rzeczywistym za pomocą klawiatury.
- **Wysoka Wydajność**: Wykorzystanie assemblera pozwala na maksymalizację wydajności podczas generowania fraktala.

## Wymagania

- **NASM (Netwide Assembler)**: Kompilator assemblera.
- **Biblioteka Allegro**: Do obsługi grafiki i interakcji w czasie rzeczywistym.
- **CMake**: Do konfiguracji i budowania projektu.
- **Kompatybilny kompilator C++**: Do budowania części projektu napisanej w C++.

## Instalacja

1. **Zainstaluj NASM**: [Pobierz i zainstaluj NASM](https://www.nasm.us/pub/nasm/releasebuilds/).
2. **Zainstaluj bibliotekę Allegro**:
   - Możesz znaleźć instrukcje instalacji na stronie [Allegro](https://liballeg.org/).
3. **Sklonuj repozytorium**:
   ```sh
   git clone https://github.com/twoje_repozytorium/mandelbrot-explorer.git
   cd mandelbrot-explorer
   ```
4. **Skonfiguruj projekt za pomocą CMake**:
   ```sh
   cmake .
   make
   ```

## Użycie

Po zbudowaniu projektu, uruchom plik wykonywalny:
```sh
./mandelbrot
```

### Sterowanie

- **WSAD**: Przesuwanie widoku.
- **QE**: Przybliżanie widoku.

## Autor

Rafał Mironko
