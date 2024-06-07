#include <allegro5/allegro5.h>
#include <allegro5/allegro_font.h>
#include <vector>
#include <algorithm>
#include "generateMandelbrotSet.h"

const int WIDTH = 400;
const int HEIGHT = 400;

double max(double a, double b) {
    return (a < b) ? b : a;
}

void displayRGBPixels(const std::vector<uint8_t>& pixelArray, int width, int height) {
    for (int row = 0; row < height; ++row) {
        for (int col = 0; col < width; ++col) {
            int pixelIdx = 3 * (row * width + col);
            al_draw_pixel(col, row, al_map_rgb(
                pixelArray[pixelIdx],
                pixelArray[pixelIdx + 1],
                pixelArray[pixelIdx + 2]
            ));
        }
    }
}

int main() {
    al_init();
    al_install_keyboard();

    ALLEGRO_TIMER *timer = al_create_timer(1.0 / 60.0);
    ALLEGRO_EVENT_QUEUE *queue = al_create_event_queue();
    ALLEGRO_DISPLAY *disp = al_create_display(WIDTH, HEIGHT);
    ALLEGRO_FONT *font = al_create_builtin_font();

    al_register_event_source(queue, al_get_keyboard_event_source());
    al_register_event_source(queue, al_get_timer_event_source(timer));

    bool redraw = true;
    ALLEGRO_EVENT event;

    std::vector<uint8_t> pixels(WIDTH * HEIGHT * 3);
    double offsetReal = static_cast<double>(WIDTH) / 2;
    double offsetImag = static_cast<double>(HEIGHT) / 2;
    double zoom = 1.0;

    double cReal = 0;
    double cImag = 0;
    double escapeRadius = 2.0;

    double deltaOffset = 10.0;
    double deltaZoom = 0.05;

    generateMandelbrotSet(pixels.data(), WIDTH, HEIGHT, escapeRadius, cReal, cImag, offsetReal, offsetImag, zoom);
    displayRGBPixels(pixels, WIDTH, HEIGHT);

    al_start_timer(timer);
    while (true) {
        al_wait_for_event(queue, &event);

        if (event.type == ALLEGRO_EVENT_KEY_CHAR) {
            if (event.keyboard.keycode == ALLEGRO_KEY_ESCAPE) {
                break;
            }

            if (event.keyboard.keycode == ALLEGRO_KEY_S) {
                offsetImag -= deltaOffset;
            } else if (event.keyboard.keycode == ALLEGRO_KEY_D) {
                offsetReal -= deltaOffset;
            } else if (event.keyboard.keycode == ALLEGRO_KEY_W) {
                offsetImag += deltaOffset;
            } else if (event.keyboard.keycode == ALLEGRO_KEY_A) {
                offsetReal += deltaOffset;
            }

            if (event.keyboard.keycode == ALLEGRO_KEY_Q) {
                zoom = max(zoom - deltaZoom, 0);
            } else if (event.keyboard.keycode == ALLEGRO_KEY_E) {
                zoom += deltaZoom;
            }

            redraw = true;

        } else if (event.type == ALLEGRO_EVENT_DISPLAY_CLOSE) {
            break;
        }

        if (redraw && al_is_event_queue_empty(queue)) {
            al_clear_to_color(al_map_rgb(0, 0, 0)); // Zmiana koloru tła na czarny
            generateMandelbrotSet(pixels.data(), WIDTH, HEIGHT, escapeRadius, cReal, cImag, offsetReal, offsetImag, zoom);
            displayRGBPixels(pixels, WIDTH, HEIGHT);
            al_flip_display();

            redraw = false;
        }
    }

    al_destroy_font(font);
    al_destroy_display(disp);
    al_destroy_timer(timer);
    al_destroy_event_queue(queue);

    return 0;
}
