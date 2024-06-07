
# Mandelbrot Visualization

### Author: Rafał Mironko

---

## Project Description

**Mandelbrot Visualization** is a program written in assembly language that generates and visualizes the Mandelbrot set. Utilizing the Allegro library, the program allows for zooming and panning through the Mandelbrot set in real-time, providing an interactive experience for exploring this fractal.

## Features

- **Mandelbrot Set Generation**: The program computes and displays the Mandelbrot fractal.
- **Interactive Visualization**: Users can zoom in and pan through the Mandelbrot set in real-time using the keyboard.
- **High Performance**: Using assembly language maximizes performance during fractal generation.

## Requirements

- **NASM (Netwide Assembler)**: Assembler compiler.
- **Allegro Library**: For graphics and real-time interaction handling.
- **CMake**: For project configuration and building.
- **Compatible C++ Compiler**: For building the C++ part of the project.

## Installation

1. **Install NASM**: [Download and install NASM](https://www.nasm.us/pub/nasm/releasebuilds/).
2. **Install the Allegro library**:
   - You can find installation instructions on the [Allegro website](https://liballeg.org/).
3. **Clone the repository**:
   ```sh
   git clone https://github.com/your_repository/mandelbrot-explorer.git
   cd mandelbrot-explorer
   ```
4. **Configure the project using CMake**:
   ```sh
   cmake .
   make
   ```

## Usage

After building the project, run the executable:
```sh
./mandelbrot
```

### Controls

- **WSAD**: Pan the view.
- **QE**: Zoom the view.

## Author

Rafał Mironko
