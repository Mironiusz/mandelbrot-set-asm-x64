#ifndef GENERATE_MANDELBROT_SET_H
#define GENERATE_MANDELBROT_SET_H

#ifdef __cplusplus
extern "C" {
#endif

void generateMandelbrotSet(
        uint8_t *pixels,
        int width,
        int height,
        double escapeRadius,
        double cReal,
        double cImag,
        double centerReal,
        double centerImag,
        double zoom
);

#ifdef __cplusplus
}
#endif

#endif //GENERATE_MANDELBROT_SET_H
