cmake_minimum_required(VERSION 3.12)
project(Mandelbrot CXX ASM_NASM)

set(CMAKE_CXX_STANDARD 11)

enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <FLAGS> <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")

set(ALLEGRO_INCLUDE_DIR "/usr/include/x86_64-linux-gnu")
set(ALLEGRO_LIBRARIES "-lallegro -lallegro_font")

add_executable(mandelbrot mandelbrot.cpp generateMandelbrotSet.h generateMandelbrotSet.asm)
target_include_directories(mandelbrot PRIVATE ${ALLEGRO_INCLUDE_DIR}) # Include directories for Allegro
target_link_libraries(mandelbrot PRIVATE ${ALLEGRO_LIBRARIES}) # Link Allegro libraries
